# Building Debian packages

## Notes

```sh
sudo apt install dh-make
sudo apt install equivs
```

### Creating the libboost-threadpool-dev pkg

```sh
pkgname=libboost-threadpool-dev
pkgname_ver=${pkgname}-0.2
fn_ver=${pkgname}_0.2
SRC=~/src/github_jm/threadpool
DEST=~/tmp/threadpool/${pkgname_ver}
FILES="boost  boost-thread.pc.in  CHANGE_LOG  COPYING  debian  docs  Jamfile.v2  Jamrules  libs  LICENSE_1_0.txt  Makefile  project-root.jam  README  TODO"

mkdir -p ${DEST}
cd ${DEST}
rm -rf ${DEST}/*
cd ${SRC}
cp -Rf ${FILES} ${DEST}/
cd ${DEST}
# rm -rf ./obj-x86_64-linux-gnu
# rm -rf ./debian/libboost-threadpool-dev  # whu not a tmp folder like other pkg?
ls -a
cd ${DEST}/..
tar -zcvf ${fn_ver}.orig.tar.gz ${pkgname_ver}
cd ${DEST}
debuild -us -uc 
```

Check:

```sh
cd ${DEST}/..
dpkg -c libboost-threadpool-dev_0.2-6_amd64.deb 
sudo dpkg -i libboost-threadpool-dev_0.2-6_amd64.deb 
```

