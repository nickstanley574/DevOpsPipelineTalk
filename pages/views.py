from django.shortcuts import render
from django.http import HttpResponse
import socket
import json

def homePageView(request):
    with open('build.json') as f:
        data = json.load(f)


    text = '''
    <h2>Welcome to to the UIC pipeline demo!</h2>

    <img src="https://marketplace-cdn.atlassian.com/s/public/devops-hero-1-87966cfbc9c5713ae047551c7b22985c.png" style="width: 50%; height: 50%">

    <hr>

    <h3>Environment Information</h3>
    <ul>
        <li>Hostname: {}</li>
        <li>travis_build_id: <a href="{}">{}</a></li>
    </ul> '''.format(socket.gethostname(), data['travis_build_web_url'], data['travis_build_id'])
    return HttpResponse(text)
