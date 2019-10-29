# SBS on IBM DXチャレンジ 2019

This is the application for answering challenge from IBM

## License

All source code in the Project Seal is available jointly under the MIT License. See [M_LICENSE.md](M_LICENSE.md) for details

## Getting started

to get started with app, clone the repo and then install the need gems;

'''
$ bundle install --without production
'''

Next, migrate the database:

'''
$ rails db:migrate
'''

Finally, run the test suite to veryfy that everything is working correctly:

'''
$ rails test
'''

If the test suite passes, you'll be ready to run the application in a local server:

'''
$ rails server
'''

For more information, please contact a_maulana at sbs-infosys.co.jp
