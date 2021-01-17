var auth_response = {
    "response": 200,
    "message": "User data",
    "status": true,
    "param": {
      "email": "aku@mail.com",
      "password": "password"
    },
    "data": {
      "data": {
        "id": 9,
        "name": "aku",
        "email": "aku@mail.com",
        "email_verified_at": null,
        "created_at": "2020-12-01 08:41:59",
        "updated_at": "2020-12-01 08:41:59",
        "company": [
          {
            "id": 1,
            "name": "probus",
            "logo": "https://report-mobile.probussystem.com/image/17-12-2020 04_47_48.jpg",
            "email": "probus@mail.com",
            "phone": "7971515",
            "address": "probussytem",
            "properties": [
              {
                "type": "Restaurant",
                "outlets": [
                  {
                    "id": 1,
                    "name": "Probus Resto A",
                    "company_id": 1,
                    "type": 1,
                    "url": "https://dedarivillas.probussystem.net",
                    "email": "presto@gmail.com",
                    "phone": "24542352345",
                    "address": "Probus Resto",
                    "logo": "image\\17-12-2020 04_09_50.jpg",
                    "created_at": "2020-11-30 07:08:51",
                    "updated_at": "2020-12-17 04:10:10",
                    "logo_url": "https://report-mobile.probussystem.com/image\\17-12-2020 04_09_50.jpg"
                  }
                ]
              }
            ]
          }
        ]
      },
      "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk1OWRjZjIxMzg3OWZhZDdhNTRhNjY4NGI2NmU3ZmE0M2E1MmFlMDNiNTA0MzM0ZDA1NGM5Nzk5ZWFlNDNiMjYwMTMxMGVhNWI0ZWNhNTgxIn0.eyJhdWQiOiIxIiwianRpIjoiOTU5ZGNmMjEzODc5ZmFkN2E1NGE2Njg0YjY2ZTdmYTQzYTUyYWUwM2I1MDQzMzRkMDU0Yzk3OTllYWU0M2IyNjAxMzEwZWE1YjRlY2E1ODEiLCJpYXQiOjE2MDgxODEwNTQsIm5iZiI6MTYwODE4MTA1NCwiZXhwIjoxNjM5NzE3MDU0LCJzdWIiOiI5Iiwic2NvcGVzIjpbXX0.PlU3n8r5h3SXUPHwCHSkBhaKUm93QnSJMi8oku7-TP99CXTtB5Ai6gEIx_wjp_J4l5-xZuarftOtN5XbI-ooYgMpFe0gPkUjrR_zren5Fnp1wzoFKO3RdzMWt22ojb0_c2iJ1trKxEX1BYKaNZOm82Y5TSe3G93BTQEFeNXXicC3WEXDFPgyRPt3Zxp0KdtQBCGWAY4Q59c7QMMvkVkjeY6R86ZM5NSBACX2Z0aqJbCdbBR-qcwOZB26v8qVPyEBCKClQFPx_Pz0sV6afkS3guw5IGDfm-QdaN-gwqQ07xZ-oT9UxRM98a7opb7CCaDurvcI0JlhtoWTxk6PZ2jZvJRilffbfDPFP9P56Gb47iWp1ox9IgxFzzpOA1-xrsiPbSebWdMxYWHOGXIUEdHmMdq03hfh5QClx6Rq08x1cqIMN-IwrZABJxDRhEAHDeLBFB5gXbLNxEkI0VOtE79be5GPB-vn9346ir-4WQ1bJt-10H2zwyeVO0xsUZHCzgxEdYZIGk49D-014HPVBufM5k9T6Hh8dsSqEnMSijUz8xlb_HQvmrc_fGK_bL-WdiEmztL2jOFrPMm6DW8_cwO4zdyMgWdIr265fAKRkf9eV4IcDGDHbXXI4qcdqFA9nkABZe_QnK97JAcbr2RTRYfyryowiVX0e6poa8ch7lK7Hto"
    }
  }

var home = {
  "response": 200,
  "message": "Occupancy today",
  "status": true,
  "param": {
    "outlet": "10"
  },
  "data": {
    "data": {
      "occupancy": {
        "yesterday": 38,
        "today": 13,
        "tomorrow": 0
      },
      "roomSales": {
        "today": 395688,
        "yesterday": 1465688
      },
      "roomUnSold": {
        "today": 7,
        "yesterday": 9
      },
      "revenue": {
        "today": 30437.53846153846,
        "yesterday": 112745.23076923077
      },
      "guest": {
        "todayAdult": 2,
        "todayChild": 0,
        "yesterdayAdult": 8,
        "yesterdayChild": 0
      },
      "roomRate": {
        "today": 395688,
        "yesterday": 488562.6666666667
      },
      "lenghtOfStay": {
        "today": 2,
        "yesterday": 2
      },
      "reservationSummary": {
        "Booking": "0",
        "Confirmed": "4",
        "Canceled": "0",
        "No Show": "0"
      },
      "inHouseSummary": {
        "House Used": "0",
        "Compliment": "4",
        "Pay Room": "1",
        "Out Of Order": "1"
      },
      "roomProduction": [
        {
          "kd_agen": "AGN-NKTWC",
          "nm_agen": "AGODA (AGENT COLLECT)",
          "value": "28",
          "revenue": "261118"
        },
        {
          "kd_agen": "direct",
          "nm_agen": "Direct",
          "value": "12",
          "revenue": "394836"
        },
        {
          "kd_agen": "AGN-NK61G",
          "nm_agen": "BOOKING.COM (HOTEL COLLECT)",
          "value": "6",
          "revenue": "457201"
        },
        {
          "kd_agen": "AGN-N0BNW",
          "nm_agen": "BOOKING.COM (AGENT COLLECT)",
          "value": "6",
          "revenue": "422934"
        },
        {
          "kd_agen": "AGN-T2AZH",
          "nm_agen": "AGODA (HOTEL COLLECT)",
          "value": "6",
          "revenue": "298052"
        },
        {
          "kd_agen": "AGN-NJPGV",
          "nm_agen": "EXPEDIA (AGENT COLLECT)",
          "value": "2",
          "revenue": "267840"
        },
        {
          "kd_agen": "AGN-NJ7BS",
          "nm_agen": "TRAVELOKA (AGENT COLLECT)",
          "value": "0",
          "revenue": "0"
        },
        {
          "kd_agen": "ORZVQG",
          "nm_agen": "PAK LEO OWNER",
          "value": "0",
          "revenue": "0"
        },
        {
          "kd_agen": "AGN-MPSKU",
          "nm_agen": "EXPEDIA (HOTEL COLLECT)",
          "value": "0",
          "revenue": "0"
        },
        {
          "kd_agen": "AGN-NKIES",
          "nm_agen": "AIRBNB",
          "value": "0",
          "revenue": "0"
        }
      ]
    }
  }
}

const inHouse = {
  "response": 200,
  "message": "In house today",
  "status": true,
  "param": {
   "outlet": "7"
  },
  "data": {
   "data": [
    {
     "no_reservasi": "RES/2012/S1C86",
     "tgl_booking": "2020-12-20",
     "nama_tamu": "Ridwan Kusuma Wijaya",
     "room": "105",
     "hrg_room": "274822",
     "tgl_datang": "2020-12-20 00:00:00",
     "tgl_berang": "2020-12-24 00:00:00",
     "pax": "2",
     "pax2": "0",
     "lama": "4",
     "agen": "EXPEDIA (AGENT COLLECT)",
     "nasional": "INDONESIAN               ",
     "stt": "REGISTERED",
     "gsegmen": "FIT",
     "cm_id": "103",
     "jenis_kamar": "DEDARI VILLA",
     "total_harga": "1232280",
     "guestsegmen": "4. ONLINE TRAVEL AGENT",
     "room_rate": "Include Breakfast",
     "nm_makan": "BREAKFAST",
     "total_dp": "0",
     "reg_stt": "IN",
     "vip": "0",
     "nm_cus": "",
     "email_show": "",
     "res": false,
     "reservasi_date": [],
     "customer": null
    }
   ]
  }
 }

const arrival = {
  "response": 200,
  "message": "Arrival today",
  "status": true,
  "param": {
   "outlet": "7"
  },
  "data": {
   "data": [
    {
     "no_reservasi": "RES/2012/TU8OE",
     "tgl_booking": "2020-12-15",
     "nama_tamu": "Linda Sari Lubis",
     "room": "110",
     "hrg_room": "379905",
     "tgl_datang": "2020-12-21 00:00:00",
     "tgl_berang": "2020-12-22 00:00:00",
     "pax": "2",
     "pax2": "0",
     "lama": "1",
     "agen": "AGODA (AGENT COLLECT)",
     "nasional": "INDONESIA",
     "stt": "CONFIRMED",
     "gsegmen": "",
     "cm_id": "95",
     "jenis_kamar": "DEDARI VILLA",
     "total_harga": "379905",
     "guestsegmen": "4. ONLINE TRAVEL AGENT",
     "room_rate": "Include Breakfast",
     "nm_makan": "BREAKFAST",
     "total_dp": "0",
     "reg_stt": "",
     "vip": "0",
     "nm_cus": "",
     "email_show": "",
     "res": false,
     "reservasi_date": [],
     "customer": null
    }
   ]
  }
 }
 


 
let ini = [
  [
   {
    "no_reservasi": "RES/2012/S1C86",
    "tgl_booking": "2020-12-20",
    "nama_tamu": "Ridwan Kusuma Wijaya",
    "room": "105",
    "hrg_room": "274822",
    "tgl_datang": "2020-12-20 00:00:00",
    "tgl_berang": "2020-12-24 00:00:00",
    "pax": "2",
    "pax2": "0",
    "lama": "4",
    "agen": "EXPEDIA (AGENT COLLECT)",
    "nasional": "INDONESIAN               ",
    "stt": "REGISTERED",
    "gsegmen": "FIT",
    "cm_id": "103",
    "jenis_kamar": "DEDARI VILLA",
    "total_harga": "1232280",
    "guestsegmen": "4. ONLINE TRAVEL AGENT",
    "room_rate": "Include Breakfast",
    "nm_makan": "BREAKFAST",
    "total_dp": "0",
    "reg_stt": "IN",
    "vip": "0",
    "nm_cus": "",
    "email_show": "",
    "res": false,
    "reservasi_date": [],
    "customer": null
   }
  ],
  [],
  [
   {
    "no_reservasi": "RES/2012/TU8OE",
    "tgl_booking": "2020-12-15",
    "nama_tamu": "Linda Sari Lubis",
    "room": "110",
    "hrg_room": "379905",
    "tgl_datang": "2020-12-21 00:00:00",
    "tgl_berang": "2020-12-22 00:00:00",
    "pax": "2",
    "pax2": "0",
    "lama": "1",
    "agen": "AGODA (AGENT COLLECT)",
    "nasional": "INDONESIA                     ",
    "stt": "REGISTERED",
    "gsegmen": "FIT",
    "cm_id": "95",
    "jenis_kamar": "DEDARI VILLA",
    "total_harga": "379905",
    "guestsegmen": "4. ONLINE TRAVEL AGENT",
    "room_rate": "Include Breakfast",
    "nm_makan": "BREAKFAST",
    "total_dp": "0",
    "reg_stt": "OUT",
    "vip": "0",
    "nm_cus": "",
    "email_show": "",
    "res": false,
    "reservasi_date": [],
    "customer": null
   },
   {
    "no_reservasi": "RES/2012/6YP54",
    "tgl_booking": "2020-12-21",
    "nama_tamu": "Slobodan Marinkovic",
    "room": "104",
    "hrg_room": "550000",
    "tgl_datang": "2020-12-21 00:00:00",
    "tgl_berang": "2020-12-22 00:00:00",
    "pax": "3",
    "pax2": "0",
    "lama": "1",
    "agen": "",
    "nasional": "SERBIAN/SERBIA                ",
    "stt": "REGISTERED",
    "gsegmen": "FIT",
    "cm_id": "",
    "jenis_kamar": "DEDARI VILLA",
    "total_harga": "550000",
    "guestsegmen": "2. DIRECT WALK IN",
    "room_rate": "Include Breakfast",
    "nm_makan": "BREAKFAST",
    "total_dp": "550000",
    "reg_stt": "OUT",
    "vip": "1",
    "nm_cus": "",
    "email_show": "",
    "res": false,
    "reservasi_date": [],
    "customer": null
   }
  ],
  [
   {
    "no_reservasi": "RES/2012/HJMFW",
    "tgl_booking": "2020-12-22",
    "nama_tamu": "Lauri Eskelinen",
    "room": "111",
    "hrg_room": "349180",
    "tgl_datang": "2021-03-02 00:00:00",
    "tgl_berang": "2021-03-08 00:00:00",
    "pax": "1",
    "pax2": "0",
    "lama": "6",
    "agen": "BOOKING.COM (HOTEL COLLECT)",
    "nasional": "FINLAND",
    "stt": "CONFIRMED",
    "gsegmen": "",
    "cm_id": "104",
    "jenis_kamar": "SUPERIOR ROOM",
    "total_harga": "2095080",
    "guestsegmen": "4. ONLINE TRAVEL AGENT",
    "room_rate": "Include Breakfast",
    "nm_makan": "BREAKFAST",
    "total_dp": "0",
    "reg_stt": "",
    "vip": "0",
    "nm_cus": "",
    "email_show": "",
    "res": false,
    "reservasi_date": [],
    "customer": null
   },
   {
    "no_reservasi": "RES/2012/HLNWR",
    "tgl_booking": "2020-12-22",
    "nama_tamu": "Shared Room",
    "room": "115",
    "hrg_room": "0",
    "tgl_datang": "2021-03-02 00:00:00",
    "tgl_berang": "2021-03-08 00:00:00",
    "pax": "1",
    "pax2": "0",
    "lama": "6",
    "agen": "",
    "nasional": "",
    "stt": "SHARED",
    "gsegmen": "FIT",
    "cm_id": "",
    "jenis_kamar": "FAMILY SUITE",
    "total_harga": "0",
    "guestsegmen": "2. DIRECT WALK IN",
    "room_rate": "Room Only",
    "nm_makan": "",
    "total_dp": "0",
    "reg_stt": "",
    "vip": "0",
    "nm_cus": "",
    "email_show": "",
    "res": false,
    "reservasi_date": [],
    "customer": null
   }
  ]
 ]