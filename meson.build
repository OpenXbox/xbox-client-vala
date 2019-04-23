project('com.github.gffranco.OpenXboxClient', 'vala', 'c', version: '0.1.0')

# Compilers
c_compiler = meson.get_compiler('c')
vala_compiler = meson.get_compiler('vala')

add_project_arguments([
        '-DGETTEXT_PACKAGE=\"@0@\"'.format(meson.project_name()),
    ],
    language: 'c',
)

i18n = import('i18n')

# load meson from subdir
subdir('data')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE=\"@0@\"'.format (meson.project_name()), language:'c')

# Additional lib dir
lib_dir = join_paths(meson.source_root(), 'lib')

# Adding deps
dependencies = [
    dependency('glib-2.0', version: '>=2.38'),  
    dependency('gio-unix-2.0', version: '>=2.20'),
    dependency('granite'),
    dependency('webkit2gtk-4.0'),
    dependency('libsoup-2.4'),
    vala_compiler.find_library('XboxWebApi-1.0', dirs: vapi_dir),
    c_compiler.find_library('libXboxWebApi', dirs: lib_dir),
]

# Adds subfolders specific build system
icon_sizes = ['128', '256']
foreach i : icon_sizes
    install_data(
        join_paths('data/icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data(
        join_paths('data/icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )
endforeach

config_data = configuration_data()
config_data.set('EXEC_NAME', meson.project_name())

conf_data = configuration_data()
conf_data.set_quoted('PROJECT_NAME', meson.project_name())
conf_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf_data.set_quoted('VERSION', meson.project_version())
conf_data.set_quoted('PREFIX', get_option('prefix'))

desktop_in_file = configure_file(
    input: join_paths('data', meson.project_name() + '.desktop.in.in'),
    output: '@BASENAME@',
    configuration: config_data
)

desktop_file = i18n.merge_file(
    input: desktop_in_file,
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

appstream_file = i18n.merge_file(
    input: join_paths (meson.source_root(), 'data', meson.project_name() + '.appdata.xml.in'),
    output: '@BASENAME@',
    po_dir: join_paths(meson.source_root(), 'po'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

code_files = files(
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/LoginWindow.vala',
)
code_files += resources_src

include_dir = include_directories('lib')

executable(
    meson.project_name(),
    code_files,
    resources_src,
    dependencies: dependencies,
    include_directories: include_dir,
    install: true
)
