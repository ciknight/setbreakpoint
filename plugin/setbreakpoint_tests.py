import unittest
import setbreakpoint as sut


class Setbreakpoints_PythonTests(unittest.TestCase):

    def test_example(self):
        input = ['#!/bin/python',
                 'a = 1',
                 'for i in range(10):',
                 '\timport ipdb; ipdb.set_trace()',
                 '\tprint(i)']

        expected_output = ['#!/bin/python',
                           'a = 1',
                           'for i in range(10):',
                           '\tprint(i)']
        actual_output = sut.remove_breakpoint(input)
        self.assertEqual(expected_output, actual_output)


unittest.main()
