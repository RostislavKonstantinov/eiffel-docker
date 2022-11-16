import enum
from junitparser import TestCase, TestSuite, JUnitXml, Skipped, Error, Failure

FIRST_LINE = ''
test_cases = []


def _error(cases, msg):
    if len(cases) < 1:
        case_error = TestCase('Test cases', 'all tests', 0.1)
        case_error.result = [Error(f'{msg}', 'the_error_type')]
        test_cases.append(case_error)


def _results(input):
    if input[2] == 'FAIL':
        return [Failure(input[0] + '' + '<>' + ' ' + input[2])]
    else:
        return input


with open("junit-results.txt", "r") as _file:
    FIRST_LINE = _file.readline()
    for line in _file:
        if not line.startswith("<"):
            s = line.split()
            if len(s) >= 3 and (s[2] in ['pass', 'FAIL', 'fail', 'PASS']):
                case = TestCase(s[0], s[1], 0.5)
                test_cases.append(case)
                case.result = _results(s)


ts = TestSuite("my test suite")
_error(test_cases, FIRST_LINE)
ts.add_testcases(test_cases)


# Add suite to JunitXml
xml = JUnitXml()
xml.add_testsuite(ts)
xml.write('junit-results.xml')

# remove compiler notes from stderr
with open('errors', "w") as f:
    pass
