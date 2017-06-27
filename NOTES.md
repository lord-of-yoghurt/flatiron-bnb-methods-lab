Data structure from spec:

Models:

* City
  - name:string
  - has many neighborhoods
  - has many listings through neighborhoods

* Neighborhood
  - name:string
  - belongs to a city
  - has many listings

* Listing
  - title:string
  - description:text
  - address:string
  - listing_type:string
  - price:float
  - belongs to a neighborhood
  - belongs to a host (User - set up correct foreign key)
  - has many reservations
  - has many reviews through reservations
  - knows about its guests (has many guests through reservations)

* User
  - name:string
  - guest or host
  - as host:
    - has many listings
    - has many reviews through listings
  - as guest:
    - has many trips (reservations)
    - has created many reviews

* Review
  - description:text
  - rating:integer (1-5 only)
  - belongs to a guest
  - belongs to a reservation

* Reservation
  - checkin_time:date
  - checkout_time:date
  - belongs to a guest
  - belongs to a listing
