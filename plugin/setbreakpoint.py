import re


def get_breakpoint_cmd():
    try:
        import ipdb
        del ipdb
        spdb = 'ipdb'
    except ImportError:
        import pdb
        del pdb
        spdb = 'pdb'

    return 'import {}; {}.set_trace()  # yapf: disable # noqa'.format(spdb, spdb)


def remove_breakpoint(code):
    return [row for row in code if re.search('set_trace\(\)', row) is None]


def remove_breakpoints(code):
    return (remove_breakpoint(code))
