#!/usr/bin/env bash
# platform = multi_platform_all
# check-import = stdout

{{{ find_files(
    find_parameters="-nogroup",
    fail_message="Found ungroupowned files",
    exclude_directories="sysroot"
) }}}

{{{ find_directories(
    find_parameters="-nogroup",
    fail_message="Found ungroupowned directories",
    exclude_directories="sysroot"
) }}}
