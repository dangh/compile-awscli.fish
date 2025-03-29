function compile-awscli
  which -s python3.12 || begin
    echo Python 3.12 is required for compilation.
    return 1
  end

  set WORK_DIR (mktemp -d)

  python3.12 -m venv $WORK_DIR
  source $WORK_DIR/bin/activate.fish
  pip3 install virtualenv

  mkdir $WORK_DIR/source
  curl --silent https://awscli.amazonaws.com/awscli.tar.gz | tar --directory $WORK_DIR/source --extract --gzip --strip-components=1
  pushd $WORK_DIR/source
  ./configure --with-download-deps --with-install-type=portable-exe
  make
  sudo make install
  popd

  sudo rm -rf $WORK_DIR

  file (which aws)
  command aws --version
end
