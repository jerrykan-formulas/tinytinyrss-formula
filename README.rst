=============
Tiny Tiny RSS
=============

Formula to install and configure the Tiny Tiny RSS news feed reader.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Notes
=====

This formula does not initialise the tinytinyrss database as would occur if the
user was using the web interface installer. The database can be initialised by
hand using one of the following commands.

PostgreSQL::

    $ PGPASSWORD="<db_pass>" psql -h <db_host> -f <install_dir>/schema/ttrss_schema_pgsql.sql <db_name> <db_user> 

MySQL::

    $ mysql -h <db_host> -u <db_user> -p<db_pass> jerrykan_reader < <install_dir>/schema/ttrss_schema_mysql.sql


Available states
================

.. contents::
    :local:

``tinytinyrss``
---------------

Installs and configures the Tiny Tiny RSS files.

``tinytinyrss.cron``
--------------------

Configure a cronjob to keep feeds up-to-date.
