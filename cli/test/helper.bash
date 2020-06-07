# Test suite
FILENAME=`basename $BATS_TEST_FILENAME`
TEST_SUBDIR=`basename $BATS_TEST_DIRNAME`
TEST_SUITE=cli::${TEST_SUBDIR}::${FILENAME%.*}

# Repo dirs and files
ROOT=${BATS_TEST_DIRNAME}/../../..
CLI_DIR=${ROOT}/cli
CLI_BIN_DIR=${CLI_DIR}/bin
SANDBOXES_DIR=${BATS_TEST_DIRNAME}/../../../sandboxes

# Environment
export PATH=${CLI_BIN_DIR}:${PATH}

# Expected CLI configuration
VERSION=`$ROOT/common/version.sh`
DOCKER_IMAGE_PREFIX=mrrusof/
DOCKER_IMAGE_SUFFIX=:$VERSION
