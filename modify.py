#!/usr/bin/env python

import random

countries = ['USA', 'India', 'China', 'Russia']
browsers = ['Chromium', 'Firefox', 'Opera']

output = open('output.log', 'w')
for line in open('sample.log'):
    tokens = line.split(' ')
    tokens[1] = 'project' + str(random.randint(1, 2))
    #tokens[1] = random.choice(countries)
    #tokens[1] = random.choice(browsers)
    tokens[2] = 'user' + str(random.randint(1, 5))
    output.write(' '.join(tokens))
