#!/usr/bin/env python

import random

container_map = {}
output = open('domains.map', 'w')
for line in open('domains.log'):
    tokens = line.split(' ')
    url = tokens[6][1:]
    domain = '.'.join(url.split('.')[:3])
    container_map[domain] = ['user' + str(random.randint(1, 5)), 'project' + str(random.randint(1, 2))]

for container_id in container_map:
    output.write(container_id + "\t" + container_map[container_id][0] + "\t" + container_map[container_id][1] + "\n")
