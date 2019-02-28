from django.shortcuts import render
from django.http import HttpResponse
import socket
import json

def homePageView(request):
    with open('build.json') as f:
        data = json.load(f)


    text = '''
    <h2>Welcome to to the UIC pipeline demo!</h2>

    <img src="https://cdn-images-1.medium.com/max/1600/1*QwJOyLmOeKOSCmCNXw1CUg.png" style="width: 50%; height: 50%">

    <hr>

    <h3>Environment Information</h3>
    <ul>
        <li>Hostname: {}</li>
        <li>travis_build_id: <a href="{}">{}</a></li>
    </ul> '''.format(socket.gethostname(), data['travis_build_web_url'], data['travis_build_id'])
    return HttpResponse(text)
