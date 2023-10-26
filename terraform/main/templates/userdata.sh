#cloud-config
users:
  - name: shopkins
    sudo: [ "ALL=(ALL) NOPASSWD:ALL" ]
    shell: /bin/bash
    ssh-authorized-keys:
    - ${shopkins_public_key}
  - name: phrase_admin
    sudo: [ "ALL=(ALL) NOPASSWD:ALL" ]
    shell: /bin/bash
    ssh-authorized-keys:
    - ${admin_public_key}
  - name: phrase_user
    sudo: false
    shell: /bin/bash
    ssh-authorized-keys:
    - ${user_public_key}