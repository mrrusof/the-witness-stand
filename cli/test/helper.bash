# Test suite
FILENAME=`basename $BATS_TEST_FILENAME`
TEST_SUBDIR=`basename $BATS_TEST_DIRNAME`
TEST_SUITE=cli::${TEST_SUBDIR}::${FILENAME%.*}

# Repo dirs and files
REPO_DIR=${BATS_TEST_DIRNAME}/../../..
CLI_DIR=${REPO_DIR}/cli
CLI_BIN_DIR=${CLI_DIR}/bin
SANDBOXES_DIR=${BATS_TEST_DIRNAME}/../../../sandboxes
CHANGELOG=${REPO_DIR}/CHANGELOG.md

# Environment
export PATH=${CLI_BIN_DIR}:${PATH}

# Expected CLI configuration
VERSION=`head -n 1 $CHANGELOG | sed -e 's/# *//' -e 's/ \+/-/'`
DOCKER_IMAGE_PREFIX=mrrusof/
DOCKER_IMAGE_SUFFIX=:$VERSION

