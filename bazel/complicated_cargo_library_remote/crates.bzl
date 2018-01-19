"""
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""

def complicated_fetch_remote_crates():

    native.new_http_archive(
        name = "complicated__aho_corasick__0_6_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/aho-corasick/aho-corasick-0.6.4.crate",
        type = "tar.gz",
        strip_prefix = "aho-corasick-0.6.4",
        build_file = "//complicated_cargo_library_remote:aho-corasick-0.6.4.BUILD"
    )

    native.new_http_archive(
        name = "complicated__arrayvec__0_3_25",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/arrayvec/arrayvec-0.3.25.crate",
        type = "tar.gz",
        strip_prefix = "arrayvec-0.3.25",
        build_file = "//complicated_cargo_library_remote:arrayvec-0.3.25.BUILD"
    )

    native.new_http_archive(
        name = "complicated__atom__0_3_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/atom/atom-0.3.4.crate",
        type = "tar.gz",
        strip_prefix = "atom-0.3.4",
        build_file = "//complicated_cargo_library_remote:atom-0.3.4.BUILD"
    )

    native.new_http_archive(
        name = "complicated__bitflags__1_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.0.1.crate",
        type = "tar.gz",
        strip_prefix = "bitflags-1.0.1",
        build_file = "//complicated_cargo_library_remote:bitflags-1.0.1.BUILD"
    )

    native.new_http_archive(
        name = "complicated__coco__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/coco/coco-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "coco-0.1.1",
        build_file = "//complicated_cargo_library_remote:coco-0.1.1.BUILD"
    )

    native.new_http_archive(
        name = "complicated__crossbeam__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crossbeam/crossbeam-0.3.2.crate",
        type = "tar.gz",
        strip_prefix = "crossbeam-0.3.2",
        build_file = "//complicated_cargo_library_remote:crossbeam-0.3.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__derivative__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/derivative/derivative-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "derivative-1.0.0",
        build_file = "//complicated_cargo_library_remote:derivative-1.0.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__either__1_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/either/either-1.4.0.crate",
        type = "tar.gz",
        strip_prefix = "either-1.4.0",
        build_file = "//complicated_cargo_library_remote:either-1.4.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__fnv__1_0_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fnv/fnv-1.0.6.crate",
        type = "tar.gz",
        strip_prefix = "fnv-1.0.6",
        build_file = "//complicated_cargo_library_remote:fnv-1.0.6.BUILD"
    )

    native.new_http_archive(
        name = "complicated__fuchsia_zircon__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-zircon/fuchsia-zircon-0.3.3.crate",
        type = "tar.gz",
        strip_prefix = "fuchsia-zircon-0.3.3",
        build_file = "//complicated_cargo_library_remote:fuchsia-zircon-0.3.3.BUILD"
    )

    native.new_http_archive(
        name = "complicated__fuchsia_zircon_sys__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-zircon-sys/fuchsia-zircon-sys-0.3.3.crate",
        type = "tar.gz",
        strip_prefix = "fuchsia-zircon-sys-0.3.3",
        build_file = "//complicated_cargo_library_remote:fuchsia-zircon-sys-0.3.3.BUILD"
    )

    native.new_http_archive(
        name = "complicated__hibitset__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/hibitset/hibitset-0.3.2.crate",
        type = "tar.gz",
        strip_prefix = "hibitset-0.3.2",
        build_file = "//complicated_cargo_library_remote:hibitset-0.3.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__itertools__0_5_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/itertools/itertools-0.5.10.crate",
        type = "tar.gz",
        strip_prefix = "itertools-0.5.10",
        build_file = "//complicated_cargo_library_remote:itertools-0.5.10.BUILD"
    )

    native.new_http_archive(
        name = "complicated__lazy_static__0_2_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-0.2.11.crate",
        type = "tar.gz",
        strip_prefix = "lazy_static-0.2.11",
        build_file = "//complicated_cargo_library_remote:lazy_static-0.2.11.BUILD"
    )

    native.new_http_archive(
        name = "complicated__lazy_static__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "lazy_static-1.0.0",
        build_file = "//complicated_cargo_library_remote:lazy_static-1.0.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__libc__0_2_36",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.36.crate",
        type = "tar.gz",
        strip_prefix = "libc-0.2.36",
        build_file = "//complicated_cargo_library_remote:libc-0.2.36.BUILD"
    )

    native.new_http_archive(
        name = "complicated__memchr__2_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memchr/memchr-2.0.1.crate",
        type = "tar.gz",
        strip_prefix = "memchr-2.0.1",
        build_file = "//complicated_cargo_library_remote:memchr-2.0.1.BUILD"
    )

    native.new_http_archive(
        name = "complicated__mopa__0_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/mopa/mopa-0.2.2.crate",
        type = "tar.gz",
        strip_prefix = "mopa-0.2.2",
        build_file = "//complicated_cargo_library_remote:mopa-0.2.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__nodrop__0_1_12",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nodrop/nodrop-0.1.12.crate",
        type = "tar.gz",
        strip_prefix = "nodrop-0.1.12",
        build_file = "//complicated_cargo_library_remote:nodrop-0.1.12.BUILD"
    )

    native.new_http_archive(
        name = "complicated__num_cpus__1_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num_cpus/num_cpus-1.8.0.crate",
        type = "tar.gz",
        strip_prefix = "num_cpus-1.8.0",
        build_file = "//complicated_cargo_library_remote:num_cpus-1.8.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__odds__0_2_26",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/odds/odds-0.2.26.crate",
        type = "tar.gz",
        strip_prefix = "odds-0.2.26",
        build_file = "//complicated_cargo_library_remote:odds-0.2.26.BUILD"
    )

    native.new_http_archive(
        name = "complicated__pulse__0_5_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pulse/pulse-0.5.3.crate",
        type = "tar.gz",
        strip_prefix = "pulse-0.5.3",
        build_file = "//complicated_cargo_library_remote:pulse-0.5.3.BUILD"
    )

    native.new_http_archive(
        name = "complicated__quote__0_3_15",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quote/quote-0.3.15.crate",
        type = "tar.gz",
        strip_prefix = "quote-0.3.15",
        build_file = "//complicated_cargo_library_remote:quote-0.3.15.BUILD"
    )

    native.new_http_archive(
        name = "complicated__rand__0_3_20",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.3.20.crate",
        type = "tar.gz",
        strip_prefix = "rand-0.3.20",
        build_file = "//complicated_cargo_library_remote:rand-0.3.20.BUILD"
    )

    native.new_http_archive(
        name = "complicated__rayon__0_8_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rayon/rayon-0.8.2.crate",
        type = "tar.gz",
        strip_prefix = "rayon-0.8.2",
        build_file = "//complicated_cargo_library_remote:rayon-0.8.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__rayon_core__1_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rayon-core/rayon-core-1.3.0.crate",
        type = "tar.gz",
        strip_prefix = "rayon-core-1.3.0",
        build_file = "//complicated_cargo_library_remote:rayon-core-1.3.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__redox_syscall__0_1_37",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/redox_syscall/redox_syscall-0.1.37.crate",
        type = "tar.gz",
        strip_prefix = "redox_syscall-0.1.37",
        build_file = "//complicated_cargo_library_remote:redox_syscall-0.1.37.BUILD"
    )

    native.new_http_archive(
        name = "complicated__regex__0_2_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex/regex-0.2.5.crate",
        type = "tar.gz",
        strip_prefix = "regex-0.2.5",
        build_file = "//complicated_cargo_library_remote:regex-0.2.5.BUILD"
    )

    native.new_http_archive(
        name = "complicated__regex_syntax__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex-syntax/regex-syntax-0.4.2.crate",
        type = "tar.gz",
        strip_prefix = "regex-syntax-0.4.2",
        build_file = "//complicated_cargo_library_remote:regex-syntax-0.4.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__scopeguard__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/scopeguard/scopeguard-0.3.3.crate",
        type = "tar.gz",
        strip_prefix = "scopeguard-0.3.3",
        build_file = "//complicated_cargo_library_remote:scopeguard-0.3.3.BUILD"
    )

    native.new_http_archive(
        name = "complicated__shred__0_5_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/shred/shred-0.5.2.crate",
        type = "tar.gz",
        strip_prefix = "shred-0.5.2",
        build_file = "//complicated_cargo_library_remote:shred-0.5.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__shred_derive__0_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/shred-derive/shred-derive-0.3.0.crate",
        type = "tar.gz",
        strip_prefix = "shred-derive-0.3.0",
        build_file = "//complicated_cargo_library_remote:shred-derive-0.3.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__smallvec__0_4_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/smallvec/smallvec-0.4.4.crate",
        type = "tar.gz",
        strip_prefix = "smallvec-0.4.4",
        build_file = "//complicated_cargo_library_remote:smallvec-0.4.4.BUILD"
    )

    native.new_http_archive(
        name = "complicated__specs__0_10_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/specs/specs-0.10.0.crate",
        type = "tar.gz",
        strip_prefix = "specs-0.10.0",
        build_file = "//complicated_cargo_library_remote:specs-0.10.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__syn__0_10_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/syn/syn-0.10.8.crate",
        type = "tar.gz",
        strip_prefix = "syn-0.10.8",
        build_file = "//complicated_cargo_library_remote:syn-0.10.8.BUILD"
    )

    native.new_http_archive(
        name = "complicated__syn__0_11_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/syn/syn-0.11.11.crate",
        type = "tar.gz",
        strip_prefix = "syn-0.11.11",
        build_file = "//complicated_cargo_library_remote:syn-0.11.11.BUILD"
    )

    native.new_http_archive(
        name = "complicated__synom__0_11_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/synom/synom-0.11.3.crate",
        type = "tar.gz",
        strip_prefix = "synom-0.11.3",
        build_file = "//complicated_cargo_library_remote:synom-0.11.3.BUILD"
    )

    native.new_http_archive(
        name = "complicated__thread_local__0_3_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thread_local/thread_local-0.3.5.crate",
        type = "tar.gz",
        strip_prefix = "thread_local-0.3.5",
        build_file = "//complicated_cargo_library_remote:thread_local-0.3.5.BUILD"
    )

    native.new_http_archive(
        name = "complicated__time__0_1_39",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/time/time-0.1.39.crate",
        type = "tar.gz",
        strip_prefix = "time-0.1.39",
        build_file = "//complicated_cargo_library_remote:time-0.1.39.BUILD"
    )

    native.new_http_archive(
        name = "complicated__tuple_utils__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tuple_utils/tuple_utils-0.2.0.crate",
        type = "tar.gz",
        strip_prefix = "tuple_utils-0.2.0",
        build_file = "//complicated_cargo_library_remote:tuple_utils-0.2.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__unicode_xid__0_0_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-xid/unicode-xid-0.0.4.crate",
        type = "tar.gz",
        strip_prefix = "unicode-xid-0.0.4",
        build_file = "//complicated_cargo_library_remote:unicode-xid-0.0.4.BUILD"
    )

    native.new_http_archive(
        name = "complicated__unreachable__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unreachable/unreachable-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "unreachable-1.0.0",
        build_file = "//complicated_cargo_library_remote:unreachable-1.0.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__utf8_ranges__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/utf8-ranges/utf8-ranges-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "utf8-ranges-1.0.0",
        build_file = "//complicated_cargo_library_remote:utf8-ranges-1.0.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__void__1_0_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/void/void-1.0.2.crate",
        type = "tar.gz",
        strip_prefix = "void-1.0.2",
        build_file = "//complicated_cargo_library_remote:void-1.0.2.BUILD"
    )

    native.new_http_archive(
        name = "complicated__winapi__0_3_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.4.crate",
        type = "tar.gz",
        strip_prefix = "winapi-0.3.4",
        build_file = "//complicated_cargo_library_remote:winapi-0.3.4.BUILD"
    )

    native.new_http_archive(
        name = "complicated__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = "//complicated_cargo_library_remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD"
    )

    native.new_http_archive(
        name = "complicated__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = "//complicated_cargo_library_remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD"
    )

