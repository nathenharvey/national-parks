pkg_name=national-parks
pkg_description="A sample JavaEE Web app deployed in the Tomcat8 package"
pkg_origin=nathenharvey
pkg_version=0.2.0
pkg_maintainer="Nathen Harvey <nharvey@chef.io>"
pkg_license=('Apache-2.0')
pkg_source=https://github.com/billmeyer/national-parks
pkg_deps=(core/tomcat8 billmeyer/mongodb)
pkg_build_deps=(core/maven)
pkg_expose=(8080)
pkg_svc_user="root"

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  export JAVA_HOME=$(hab pkg path core/jdk8)

  cp -vr $PLAN_CONTEXT/../* $HAB_CACHE_SRC_PATH/$pkg_dirname
  mvn package
}

do_install() {
  local source_dir="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  local webapps_dir="$(hab pkg path core/tomcat8)/tc/webapps"
  cp ${source_dir}/target/${pkg_filename}.war ${webapps_dir}/
  cp ${source_dir}/national-parks.json $(hab pkg path ${pkg_origin}/national-parks)/
}
