from setuptools import setup, find_packages


with open('README.md') as readme:
    long_description = readme.read()

setup(
    name='test-bachat',
    version='0.0.1',
    description='Celery tasks supporting the operations of edX\'s ecommerce service',
    long_description=long_description,
    classifiers=[
        'Development Status :: 3 - Alpha',
        'License :: OSI Approved :: GNU Affero General Public License v3',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2.7',
        'Topic :: Internet',
        'Intended Audience :: Developers',
        'Environment :: Web Environment',
    ],
    keywords='ihassan test jenkins',
    url='https://github.com/syedimranhassan/ihpkg',
    author='ihassan',
    author_email='ihassan@edx.org',
    license='AGPL',
    packages=find_packages(exclude=['*.tests']),
    install_requires=[
        'celery>=3.1.18,<4.0.0',
        'edx-rest-api-client>=1.5.0,<2.0.0'
    ],
)
