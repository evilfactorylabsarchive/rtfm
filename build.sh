yum install python

curl https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py | python

# Install required dependencies
pipenv install

# Build our theme assets
cd theme/mkdocs-material-custom

yarn
yarn build

cd ../..

# Build our docs
pipenv run mkdocs build -f mkdocs.yml

# Copy .well-known dir to our site after build
mv ./.well-known site
