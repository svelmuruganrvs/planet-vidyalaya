What is this?
====================

This is a template for `Planet Venus`_ feed aggregator inspired by `Planet Gnome`_.

.. _`Planet Venus`: http://intertwingly.net/code/venus
.. _`Planet Gnome`: http://planet.gnome.com

Workflow
===================

  1. Student submits his blog by clicking "Add your Blog" on main page.
  2. The data will be saved in Google Spreadsheet.
  3. A member from IT Services team will verify the submitted data and approves.
  4. Hourly update script will pull approved sites data from spreadsheet and updates RSS link if empty.
  5. All approved sites will be checked for updates and Planet will be updated with new entries.


External Dependencies
==============================

  1. Django >= 1.2.1
  2. Planet Venus
  3. gdata >= 2.0.11
