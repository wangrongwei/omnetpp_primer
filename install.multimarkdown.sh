git clone git@github.com:fletcher/MultiMarkdown-6.git

cd MultiMarkdown*
./update_submodules.sh

make release 
cd build
make

cp multimarkdown /usr/local/bin/
