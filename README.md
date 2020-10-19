# test.sh
Minimalistic test framework for shell scripts.

A test setup consists of `tests.sh` as test-runner (or `run.sh`), which is to be
copied into your project, combined with test files (named `*.test.sh`) which
contain the actual tests.

A complete test run consists of:
- a test suite
- which consists of 1 or more test-files
- which contains 1 or more chapters
- which contain 1 or more tests

To create a new test file run:

```shell
./test.sh --create mytestfile "test suite name"
```

Instructions will be in the generated file.

## Examples

[Kong Pongo](https://github.com/Kong/kong-pongo/tree/master/assets/ci)

[Kong Docker](https://github.com/Kong/docker-kong/tree/master/tests)

Try this:
```shell
# create new test files
./test.sh --create my_test "Yolo Suite 1"
./test.sh --create my_test2 "Yolo Suite 2"

# run a single file
./my_test.test.sh

# run multiple files
./test.sh --suite "Suite 42" my_test.test.sh my_test2.test.sh

# run all files
./test.sh --suite "Suite 42"

# run all files, with the latest master of `test.sh`
./run.sh --suite "Suite 42"
```

## Dependencies

The script is standalone, an optional dependency is `figlet` to make headers
stand out in the output.

## Running tests

To use `test.sh` copy the `test.sh` file into your project. Alternatively if you
like living on the edge, copy `run.sh` which is identical, except that it always
pulls the latest version of `test.sh` from github.

### Usage `test.sh`:

- `./test.sh [--suite <suite name>] [files...]`

  Runs the tests.

  Arguments:
  * `--suite <suite name>` (optional) The suite name, defaults to "unknown
    test suite". This name will override the name in the individual test files.
  * `[files...]` (optional) List of test files to execute. By default it will
    run all `*.test.sh` files located in the same directory as `test.sh`.

- `./test.sh --create <testfile> <suite name>`

  Creates a new template test file.

  Arguments:
  * `<test file>` (required) filename of the testfile, the extension `.test.sh`
    will automatically be appended.
  * `<suite name>` (required) name of the test suite.



### Usage test files (`*.test.sh`):

- `./this.test.sh [path-to-test.sh]`:
  When "path-to-test.sh" is not provided it defaults to the same directory where
  the test file is located.


Assuming `test.sh` is in the same directory as this file:

- `/some/path/this.test.sh` runs only this file
- `/some/path/test.sh` runs all "/some/path/*.test.sh" files
- `/some/path/test.sh this.test.sh that.test.sh` runs "this.test.sh" and "that.test.sh" files

When not in the same directory

- `/some/path/this.test.sh other/path/test.sh`: runs only this file
- `/other/path/test.sh /some/path/this.test.sh`: runs only this file


## Commands

* `tinitialize <test suite name> [filename]`

  Initializes a single test file. Every `tinitialize`
  must be followed by a `tfinish`, after the tests are completed.
  
  Arguments:
  * `<test suite name>` (required) name of the test suite. Only used when the
    test-file is ran independently. Will be ignored when ran in a set of
    test-files (ran as `./test.sh --suite=<suite-name>`).
  * `[filename]` (optional) filename of the testfile


* `tchapter <chapter name>`

  Initializes a test chapter. Call after `tinitialize`, and before `ttest`. A
  chapter ends either by calling `tchapter` again (to initialize the next
  chapter), or by calling `tfinish` to finish the test file.

  Arguments:
  * `<chapter name>` (required) name of the test chapter


* `ttest <test name>`

  Starts a test. Call after `tchapter`, must be followed by `tsuccess` or
  `tfailure`.

  Arguments:
  * `<test name>` (required) name of the test

* `tdebug`

  Can be called after `ttest`, will set `set -x` for debug output, and will
  automatically be ended when the test ends (when either `tsuccess` or
  `tfailure` is called).

* `tmessage [args...]`

  Outputs a message. Typically used before calling `tfailure` to explain the
  reason of the failure.

* `tfailure`

  Marks the end of a test, with a failure.

* `tsuccess`

  Marks the end of a test, with a success.

* `tfinish`

  Marks the end of a test file.

## License

See [LICENSE](LICENSE)
