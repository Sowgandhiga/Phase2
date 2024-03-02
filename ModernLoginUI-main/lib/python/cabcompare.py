# import pandas as pd
# import googlemaps
# from flask import Flask, request, jsonify
# import json

# response=''
# pickup=''
# app= Flask(__name__)
# @app.route('/',methods =['GET','POST'])
# def nameRoute():
#     global response
#     if(request.method=='POST'):
#         request_data=request.data
#         request_data=json.loads[request_data.decode('utf-8')]
#         pickup=request_data['pickup']
#         destination=request_data['destination'] 
# # Read the CabCompare.csv file
# data = pd.read_csv("lib/python/CabCompare.csv")

# # Define the desired source and destination
# source = pickup

# destination = input("Enter the drop point: ")

# filtered_data = data[
#     (data["Source"] == source)
#     & (data["Destination"] == destination)
    
# ]
# success_rates = {}
# best_cab_type = None
# best_cost = float("inf")


# if best_cab_type is None:
#     # Use Google Maps API to find nearby locations
#     google_maps = googlemaps.Client(key='AIzaSyCzW_wMpqfFaHJAlY_7YwyIY7fAsJMCIwY')

#     geocode_result = google_maps.geocode(source)
#     if len(geocode_result) > 0 and "geometry" in geocode_result[0]:
#         source_lat, source_lng = geocode_result[0]["geometry"]["location"]
#     else:
#         # Handle error: source address could not be geocoded
#         pass

#     geocode_result = google_maps.geocode(destination)
#     if len(geocode_result) > 0 and "geometry" in geocode_result[0]:
#         destination_lat, destination_lng = geocode_result[0]["geometry"]["location"]
#     else:
#         # Handle error: destination address could not be geocoded
#         pass
# filtered_data = data[(data['Source'] == source) & (data['Destination'] == destination)]
# success_rate = filtered_data['Availability'].groupby(filtered_data['Cab_App_Type']).min()
# largest_success_rate = success_rate.idxmin()

# # Print the filtered data details for the smallest success rate

# print("Largest Success Rate:", largest_success_rate)
# test = filtered_data[filtered_data['Cab_App_Type'] == largest_success_rate]
# test=test.drop(['Date','Time','Source','Destination'],axis=1).reset_index(drop=True)
# test=test.rename(columns={'Availability':'Success_Rate'})
# print(test.head())
# import pandas as pd
# import googlemaps
# from flask import Flask, request, jsonify
# import json
# data = pd.read_csv("E:\Source Code\Phase2\ModernLoginUI-main\lib\python\CabCompare.csv")

# app = Flask(__name__)

# @app.route('/', methods=['GET', 'POST'])
# def nameRoute():
#     if request.method == 'POST':
#         #request_data = request.get_json()
#         pickup = request.get_json('pickup')
#         destination = request.get_json('destination')
#         # Read the CabCompare.csv file
        

#         # Define the desired source and destination
#         source = pickup
#         destination = destination

#         # Filter the data based on the source and destination
#         filtered_data = data[
#             (data["Source"] == source)
#             & (data["Destination"] == destination)
#         ]

#         # Calculate the success rate for each cab type
#         success_rate = filtered_data['Availability'].groupby(filtered_data['Cab_App_Type']).min()
#         # Find the cab type with the largest success rate
#         largest_success_rate = success_rate.idxmin()

#         # Get the filtered data details for the smallest success rate
#         test = filtered_data[filtered_data['Cab_App_Type'] == largest_success_rate]
#         test = test.drop(['Date', 'Time', 'Source', 'Destination'], axis=1).reset_index(drop=True)
#         test = test.rename(columns={'Availability': 'Success_Rate'})

#         # Convert the filtered data to a JSON response
#         response = test.to_json(orient='records')
#         response = json.loads(response)

#         # Return the JSON response
#         return jsonify(response)

# if __name__ == '__main__':
#     app.run(debug=True)

import pandas as pd
import googlemaps
from flask import Flask, request, jsonify
import json

data = pd.read_csv("E:/Source Code/Phase2/ModernLoginUI-main/lib/python/CabCompare.csv")

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def nameRoute():
    if request.method == 'POST':
        # Parse the request data using request.get_json()
        request_data = request.get_json()
        
        # Add a JSON schema to the request body
        request_schema = {
            "type": "object",
            "properties": {
                "pickup": {"type": "string"},
                "destination": {"type": "string"}
            },
            "required": ["pickup", "destination"]
        }
        try:
            json.loads(request.data, strict=True, object_hook=lambda d: None if ''.join(d.keys()) == '{}' else d)
        except ValueError as e:
            return jsonify({"error": "Invalid request data", "message": str(e)}), 400
        
        # Access the pickup and destination fields from the request_data dictionary
        pickup = request_data['pickup']
        destination = request_data['destination']
        
        # Filter the data based on the source and destination
        filtered_data = data[
            (data["Source"] == pickup)
            & (data["Destination"] == destination)
        ]
        
        # Calculate the success rate for each cab type
        success_rate = filtered_data['Availability'].groupby(filtered_data['Cab_App_Type']).min()
        
        # Find the cab type with the largest success rate
        largest_success_rate = success_rate.idxmin()
        
        # Get the filtered data details for the smallest success rate
        test = filtered_data[filtered_data['Cab_App_Type'] == largest_success_rate]
        test = test.drop(['Date', 'Time', 'Source', 'Destination'], axis=1).reset_index(drop=True)
        test = test.rename(columns={'Availability': 'Success_Rate'})
        
        # Convert the filtered data to a JSON response
        response = test.to_json(orient='records')
        response = json.loads(response)
        
        # Return the JSON response
        return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)