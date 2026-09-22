#!/usr/bin/env bash
# platform = multi_platform_all
# check-import = stdout

{{{ find_files(
    find_parameters="-nouser",
    fail_message="Found unowned files",
    exclude_directories="sysroot"
) }}}

{{{ find_directories(
    find_parameters="-nouser",
    fail_message="Found unowned directories",
    exclude_directories="sysroot"
) }}}
