---
# RedHat stuff (needs testing)
- name: Install the required  packages in Redhat derivatives
  yum: name={{ item }} state=installed
  with_items: "{{ network_pkgs }}"
  when: network_check_packages

- name: Write configuration files for rhel route configuration with vlan
  template: src=route_{{ ansible_os_family }}.j2 dest={{ net_path }}/route-{{ item.device }}
  with_items: "{{ network_vlan_interfaces }}"
  when: network_ether_interfaces is defined and item.route is defined
  tags:
    - network_vlan_interfaces

- name: Write configuration files for rhel route configuration
  template: src=route_{{ ansible_os_family }}.j2 dest={{ net_path }}/route-{{ item.device }}
  with_items: "{{ network_ether_interfaces }}"
  when: network_ether_interfaces is defined and item.route is defined
  tags:
    - network_ether_interfaces

- name: Write configuration files for route configuration
  template: src=route_{{ ansible_os_family }}.j2 dest={{ net_path }}/route-{{ item.device }}
  with_items: "{{ network_bond_interfaces }}"
  when: network_bond_interfaces is defined and item.route is defined
  tags:
    - network_bond_interfaces

- name: Write configuration files for rhel route configuration
  template: src=route_{{ ansible_os_family }}.j2 dest={{ net_path }}/route-{{ item.device }}
  with_items: "{{ network_bridge_interfaces }}"
  when: network_bridge_interfaces is defined and item.route is defined
  tags:
    - network_bridge_interfaces
