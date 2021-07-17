<?php
include('conexion.php');
//Politicas de Niños

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/children-policies?hotel_id=1676161&locale=es-mx-gb&children_age=5",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->politicas_niños;
$result = $collection-> insertOne($data);

curl_close($curl);


//Descripcion del hotel
$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/review-scores?locale=es-mx&hotel_id=1676161",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->descripcion_hotel;
$result = $collection->insertMany([$data]);
//$result = $collection->deleteO(['hotel_id' => '1676161']);
curl_close($curl);


//Factura
$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/payment-features?hotel_id=1676161&locale=es-mx",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->factura;
$result = $collection->insertMany($data);
//$result = $collection->deleteOne(['creditcard_id' => 2]);
curl_close($curl);


//Ubicacion del Hotel
$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/map-markers?hotel_id=1676161&locale=es-mx",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->ubicacion_hotel;
$result = $collection->insertOne($data);
curl_close($curl);


//Localizacion del Hotel
$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/locations?locale=es-mx&name=Honduras",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->localizacion_hotel;
$result = $collection->insertMany($data);
curl_close($curl);


//Comentarios
$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/reviews?sort_type=SORT_MOST_RELEVANT&hotel_id=1676161&locale=es-mx&language_filter=en-gb%2Cde%2Cfr&customer_type=solo_traveller%2Creview_category_group_of_friends",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->comentarios_hotel;
$result = $collection->insertOne([$data]);

curl_close($curl);


//Tips del hotel
$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/tips?hotel_id=1676161&locale=es-mx&sort_type=SORT_MOST_RELEVANT&customer_type=solo_traveller%2Creview_category_group_of_friends&language_filter=en-gb%2Cde%2Cfr",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_FOLLOWLOCATION => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"x-rapidapi-host: booking-com.p.rapidapi.com",
		"x-rapidapi-key: 2e8d4eb532mshbaa3756884c6badp1e0913jsnd6ad94871559"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);
$data = json_decode($response);
$collection = $client->proyecto->tips_hotel;
$result = $collection->insertOne($data);
curl_close($curl);

//-------------------------------------------------------------------------------------------------------

//FIN DE LA CONEXION 

//FOTOS DEL HOTEL 1998

$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/photos?hotel_id=1676161&locale=es-mx",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
  CURLOPT_HTTPHEADER => [
    "x-rapidapi-host: booking-com.p.rapidapi.com",
    "x-rapidapi-key: b01e0b6b5emsh39bb801a5a9e4a3p1125b9jsn2425919205a9"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);


$collection = $client->proyecto->photos;

$data = json_decode($response);
//echo $data;
$result = $collection->insertMany($data);




// POLITICAS DEL HOTEL
$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/policies?hotel_id=1676161&locale=es-mx",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
  CURLOPT_HTTPHEADER => [
    "x-rapidapi-host: booking-com.p.rapidapi.com",
    "x-rapidapi-key: b01e0b6b5emsh39bb801a5a9e4a3p1125b9jsn2425919205a9"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

$collection = $client->proyecto->politicas;

$data = json_decode($response);
//echo $data;
$result = $collection->insertOne($data);

// Location DEL HOTEL
$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/location-highlights?locale=es-mx&hotel_id=1676161",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
  CURLOPT_HTTPHEADER => [
    "x-rapidapi-host: booking-com.p.rapidapi.com",
    "x-rapidapi-key: b01e0b6b5emsh39bb801a5a9e4a3p1125b9jsn2425919205a9"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

$collection = $client->proyecto->Location;

$data = json_decode($response);
//echo $data;
$result = $collection->insertOne($data);

// Reviuw Score DEL HOTEL
$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/review-scores?locale=es-mx&hotel_id=1676161",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
  CURLOPT_HTTPHEADER => [
    "x-rapidapi-host: booking-com.p.rapidapi.com",
    "x-rapidapi-key: b01e0b6b5emsh39bb801a5a9e4a3p1125b9jsn2425919205a9"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

$collection = $client->proyecto->Reviuw;

$data = json_decode($response);
//echo $data;
$result = $collection->insertOne($data);

// Room List DEL HOTEL
$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/room-list?currency=USD&adults_number_by_rooms=4%2C1&checkin_date=2021-11-20&units=metric&hotel_id=1676161&locale=es-mx&checkout_date=2021-11-25&children_ages=5%2C0%2C9&children_number_by_rooms=2%2C1",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
  CURLOPT_HTTPHEADER => [
    "x-rapidapi-host: booking-com.p.rapidapi.com",
    "x-rapidapi-key: b01e0b6b5emsh39bb801a5a9e4a3p1125b9jsn2425919205a9"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

$collection = $client->proyecto->Rooms;

$data = json_decode($response);
//echo $data;
$result = $collection->insertMany($data);

// Questions DEL HOTEL
$curl = curl_init();

curl_setopt_array($curl, [
  CURLOPT_URL => "https://booking-com.p.rapidapi.com/v1/hotels/questions?locale=es-mx&hotel_id=1676161",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_ENCODING => "",
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 30,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => "GET",
  CURLOPT_HTTPHEADER => [
    "x-rapidapi-host: booking-com.p.rapidapi.com",
    "x-rapidapi-key: b01e0b6b5emsh39bb801a5a9e4a3p1125b9jsn2425919205a9"
  ],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

$collection = $client->proyecto->Questions;

$data = json_decode($response);
//echo $data;
$result = $collection->insertOne($data);

?>