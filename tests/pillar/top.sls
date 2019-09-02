base:
  'test_*':
    - {{ grains.id }}

  # used when developing the formula
  'not test_* and G@virtual:VirtualBox':
    - match: compound
    - vagrant

  'not test_*':
    - default
