#!/usr/bin/env python2.7
# Filename: wifi.sh
# Author:   LIU Yang
# Create Time: Sat Oct 26 18:01:37 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
'''Connect to wifi using wpa_supplicant as back end
Scan wifi using iwlist.
Require super user permission
'''
from subprocess import check_output
import re

CONFIG_FNAME = '/etc/wpa_supplicant/wpa_supplicant.conf'
WLAN_INTERFACE_PAT = '(?m)^(?P<wlan>w.*?):'
WIFI_PAT = '(?m)ESSID:"(.*?)"'
CHECK_CONFIG_FMT = 'ssid="({})"'

WIFI_CONFIG = '''
network={
    ssid="%s"
    psk="%s"
    priority=%d
}
'''


def get_wlan_interface(pat=WLAN_INTERFACE_PAT):
    '''My platform gentoo x86-64.'''
    out = check_output('ifconfig')
    return re.search(pat, out).groupdict()['wlan']


def get_wifi_list(wlan, pat=WIFI_PAT):
    '''Need root permission

        wlan: The wlan interface
    '''
    out = check_output(['/sbin/iwlist', wlan, 'scan'])
    return re.findall(pat, out)


def has_wifi_config(wifiname, config_fname=CONFIG_FNAME):
    '''Check if the config file has configured this wifi'''
    with open(config_fname) as config_file:
        contents = config_file.read()
    search_pat = CHECK_CONFIG_FMT.format(wifiname)
    return bool(re.search(search_pat, contents))



# TODO reconstruct this function!!!!!
def choose_iteraction(list_, prompt='choose an iterm'):
    '''Choose a item from given list_
    I ll find a good library to replace this
    '''
    # TODO find an iteraction library
    print(prompt)

    checked_list = [(item, has_wifi_config(item))
            for item in list_]

    for i, tup in enumerate(checked_list):
        item, has_configed = tup
        star = '*' if has_configed else ''
        print("{0:2d} {1} {2}".format(i, item, star))

    try:
        idx = int(raw_input())
    except ValueError, err:
        raise ValueError('Input {} is not a number!'.format(err))

    if not 0 <= idx < len(list_):
        raise IndexError(
                '{} out of range! Range: (0 to {})'.format(idx, len(list_)-1))

    if checked_list[idx][1]:
        raise OSError('<{}> already configured!'.format(list_[idx]))

    return list_[idx]


def build_wifi_config(ssid, psk, priority=3):
    '''Just let people know what's the meaning of each arg'''
    return WIFI_CONFIG % (ssid, psk, priority)


def add_config(wifi_config, config_fname=CONFIG_FNAME):
    '''Add the wifi configuration to the config file
    '''
    with open(config_fname, 'a') as config_file:
        config_file.write(wifi_config)


def main():
    '''Connect to wifi

        # TODO see what's current connected wifi
        - get wlan interface's name -> wlan_name
        - get wifi list -> wifi_list
        - check if wifi in list already has config
        - choose a wifi, input passwd (interface)
        - add config to -> CONFIG_FNAME

        # not yet (or i dont want to implement it forever)
        - get /etc/init.d/net.w?
        - /etc/init.d/net.w? restart
    '''
    try:
        wlan_name = get_wlan_interface()
    except KeyError, err:
        raise KeyError(err)

    wifis = get_wifi_list(wlan_name)
    wifi  = choose_iteraction(wifis, 'Choose a wifi by enter a number: ')
    passwd = raw_input('Password for wifi <{}>: '.format(wifi))

    wifi_config = build_wifi_config(wifi, passwd)
    add_config(wifi_config, '/tmp/hehe')

    print('\nConfiguration has been wroten, restart your wlan'
          '\nLike /etc/init.d/net.w* restart'
          '\nEdit /etc/wpa_supplicant/wpa_supplicant.conf to config')

if __name__ == '__main__':
    try:
        main()
    except KeyError, err:
        print('Can not find the wlan matches the pattern:'
              ' {}'.format(repr(WLAN_INTERFACE_PAT)))
    except ValueError, err:
        print(err)
    except IndexError, err:
        print(err)
    except OSError, err:
        print(err) # TODO change a proper Error name
