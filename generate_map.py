#!/usr/bin/env python

import random

container_map = {}
output = open('container.map', 'w')
for line in open('sample.log'):
    tokens = line.split(' ')
    container_map[tokens[6][1:].split('.')[0]] = ['user' + str(random.randint(1, 5)), 'project' + str(random.randint(1, 2))]

for container_id in container_map:
    output.write(container_id + "\t" + container_map[container_id][0] + "\t" + container_map[container_id][1] + "\n")
