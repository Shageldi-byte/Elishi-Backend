import admin from "firebase-admin";

const serverConfig = {
    "type": "service_account",
    "project_id": "elishi-d4682",
    "private_key_id": "854c148e5a4552be29dc3e0d47ef1ceb8a950ab2",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC4h8szYvS88Y/K\nGLjs7G/+bhBRXrOcLdAXu5ISDzP/llu7LZIWhp8x5KvBmlPGgsLc7527hppywWK3\nCW91dtxjeeVM16VFUS5l/NTF0UuGkBFKMZKouylEixrYTZlXkhRepenEPjDmTYzt\nVZI9C515/pcZapfnmkFbeN9zsMd6alx6al4KExtgs8r89LThxMJl/qOCOvcLV4Xv\nAtN4QVjnH9AfGCWPJWiv76NXS/ZKHpzbutezDzWRZOcgWBk9B1ZTRwXEB5dbO2FE\nNL3aqI2WENTZRcpXM43XvMT3sVWmMvUACs9anB/Pj+or8+CfMcduzThOPa/2rw2L\nxqa+3b5rAgMBAAECggEAJjz5dhYI6ghSiAn0dCAQmxQarInnxTLXHrvfKn/dAhcZ\nviFU1vchkPi2QMGmn4mkMJ00vdHIOoRpXM2HO7ucMr7lLbW4CTOn3jl0q+NRd7pt\n4saAAhf6lroOn4kBAB0EvJI77U8H2gly7RFg4uZ/xPJlRD6K6NLVvUtAXpxg0bRT\nFpoYtmWrKDfx65I7S8KAtLylk4NFbOG3WgzDVe7G/wer89IpopFw2cjw9Yy+zwOK\ni73LFlGLfbpHWSHIXAJeWBzbonUYitd6u47VYf4/ZEjj8ZuLsurqpLIZK6rCMHdT\naPlUQbhEdxV0kD1ul/j8gj9QiHO8c4ESTT5MRWxpRQKBgQDwq7q/p5HeGxDs3gAg\nPlgRSVIcyj4y4AEzehscJUK5i124qLa+B/ey3wZn1Ox2w7e+Qhi8WDNU29fYUzWN\nUWxuPgXxBawzqaDtwlSalQ7jy5DnQ+6pur0OZq8RauPevvpct/wj5dqRnk+tWHQ5\nQNeYFl6ZnZ5SVGhAJ3EPidC67QKBgQDESKobwCNHGGSXnC+rkftwNuXYSp6K/h8Y\nUQfGDV4yN6MogOMzZHkm1JAEgOYabLFH7oUz59liN4BtMA9p1UDjdJ/zg3aoIcOE\nB3Vx2ouj/m1853jwg8HN/WHHAhn9swYKPKOHO9rvKZb08f+6RJ6o8ivRUUffalsg\nerBwzfG7twKBgQDHPmSsph2sstugPWn9R5/BL+I603QKykg0RbKL6o0C7s34QjSH\nvjDidKDo9O2OpRlI+Y9g3eQhLJ/VB44eIHqUCeUBVKDrZFNGgstn7l8VV0HvM94x\nxdceRQRKdyOPFKxQdkDXt0LrqxRrff86JuRVlK9cnZCkuBxWgFCpfH7BQQKBgFmI\nY7/Axta5M7lMTxpNvomTIQimEOeJvxlSbN9UXbE+W7gwAnMA05p4vzCus0c+aSdM\nj4n7qdb5RiWIFJ/L3ItkOUnUn51VuV9SH6pNbADkH4En/KyJDTAu8hjaxoxIyuqE\nentHPDh3mholAOcwQccCoCYck1I/q02HaVArQKbFAoGBAK3bHiFW0bWNnf+SKpvU\nPE/blTPGMaZ/WmXnWjVXIkePWSwH92uS5/dkX/WF0vV31O50yNUXPBIJRvSrOmsj\nOWThjiaNkG03eN/5Jns7k2pQd9WdOHe+PE35D8tH7gG/cUFYN1yhwFwvf2diMn7u\nqI7zjQi1C5d8kMtKC2lAI0Cf\n-----END PRIVATE KEY-----\n",
    "client_email": "firebase-adminsdk-pxm7t@elishi-d4682.iam.gserviceaccount.com",
    "client_id": "115626001092815042092",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-pxm7t%40elishi-d4682.iam.gserviceaccount.com"
  }
admin.initializeApp({
    credential: admin.credential.cert(serverConfig)
  })

export {admin};
