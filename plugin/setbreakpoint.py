import importlib
import re


def get_breakpoint_cmd():
    if importlib.util.find_spec("ipdb"):
        # ipdb
        spdb = 'ipdb'
    else:
        spdb = 'pdb'

    return 'import {}; {}.set_trace()  # yapf: disable # noqa'.format(spdb, spdb)


def remove_breakpoint(code):
    return [row for row in code if re.search('set_trace()', row) is None]


def remove_breakpoints(code):
    return (remove_breakpoint(code))
