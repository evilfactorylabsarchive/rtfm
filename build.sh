yum install python

curl https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py | python

# Install required dependencies
pipenv install

# Build our theme assets
cd theme

yarn
yarn build

cd ..

# Build our docs
pipenv run mkdocs build -f mkdocs.yml
