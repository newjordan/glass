"""Small deterministic tests for the new versioned placement policy/replay math."""
import copy
import importlib.util
import math
from pathlib import Path
import unittest

HERE = Path(__file__).resolve().parent

def module(name, file):
    spec = importlib.util.spec_from_file_location(name, HERE/'linux'/file)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result

r = module('role_replay_test', 'analyze-role-partition.py')
w = module('role_wrapper_test', 'role-partition.py')


def topology():
    cpus = [0, 1, 2, 3, 16, 17, 18, 19]
    rows = {str(c): dict(siblings=[c % 16, c % 16+16],core=str(c % 16),
                         package='0',l3=cpus[:],l3_size='98304K') for c in cpus}
    return cpus, rows


class RolePartitionTests(unittest.TestCase):
    def test_whole_core_split(self):
        cpus, rows = topology()
        self.assertEqual(w.validate_topology(cpus, rows), [[0, 1, 16, 17], [2, 3, 18, 19]])

    def test_reject_bad_topology(self):
        cpus, rows = topology()
        for mutation in ('siblings', 'l3', 'package', 'core'):
            with self.subTest(mutation=mutation):
                altered = copy.deepcopy(rows)
                altered['0'][mutation] = [] if mutation in ('siblings','l3') else 'different'
                with self.assertRaises(ValueError):
                    w.validate_topology(cpus, altered)
        with self.assertRaises(ValueError):
            w.validate_topology(cpus[::-1], rows)
        with self.assertRaises(ValueError):
            w.validate_topology(cpus[1:], rows)

    def test_order_position_balance(self):
        orders = r.orders(30,190031)
        self.assertEqual(orders, r.orders(30,190031))
        self.assertNotEqual(orders, r.orders(30,190032))
        for block in range(0,30,5):
            square = orders[block:block+5]
            for row in square:
                self.assertEqual(sorted(row), sorted(r.ARMS))
            for col in zip(*square):
                self.assertEqual(sorted(col), sorted(r.ARMS))

    def test_exact_median_bound(self):
        result = r.lower_bound(list(range(1,31)), .05/6)
        self.assertEqual(result['order_1based'], 9)
        self.assertEqual(result['value'],9)
        self.assertAlmostEqual(result['tail_probability'],.008062400855123997)
        self.assertGreater(sum(math.comb(30,j) for j in range(10))/2**30,.05/6)
        self.assertEqual(r.lower_bound([1.],.05/6)['value'],0.)
        self.assertEqual(r.lower_bound([1.]*30,.05/6)['value'],1.)

    def test_median_coverage_exact_small_samples(self):
        # Enumerate all equiprobable ranks-below-true-median Bernoulli outcomes.
        # At least k values below theta is precisely X_(k) <= theta.
        for n in range(1,13):
            for alpha in (.01,.05,.1):
                bound = r.lower_bound(list(range(n)),alpha)
                k = bound['order_1based']
                failure = (sum(math.comb(n,j) for j in range(k))/2**n) if k else 0.
                self.assertLessEqual(failure,alpha)
                if k < n:
                    self.assertGreater(sum(math.comb(n,j) for j in range(k+1))/2**n,alpha)

    def test_margin_strict_and_pilot_not_promotable(self):
        bound = r.lower_bound([1.05]*30,.05/6)
        self.assertFalse(bound['value'] > 1.05)
        self.assertEqual(r.lower_bound([10.]*1,.05/6)['value'],0.)

    def test_holm_monotonic(self):
        rows={str(i):dict(sign_p_two_sided=p) for i,p in enumerate([.001,.01,.03,.1,.2,1.])}
        r.holm(rows)
        self.assertEqual([rows[str(i)]['holm_p_six_workloads'] for i in range(6)], [.006,.05,.12,.30000000000000004,.4,1.])

    def test_sign_ties(self):
        result = r.sign([1.,1.1,.9])
        self.assertEqual((result['wins'], result['losses'], result['ties']), (1,1,1))
        self.assertEqual(result['sign_p_two_sided'],1.)

if __name__ == '__main__':
    unittest.main()
