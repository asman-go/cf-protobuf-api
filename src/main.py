import asyncio
import base64
import json

import schema_pb2


def event_handler(event, context):
    print('Event:', event)
    if 'body' in event:
        data = base64.b64decode(event['body'])

        program_request = schema_pb2.NewProgramRequest()
        program_request.ParseFromString(data)

        print(program_request.program_name)

        return {'status': 'OK'}
    else:
        return {'status': 'FAIL'}
