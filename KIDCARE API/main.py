from typing import Union, Optional, List
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, File, UploadFile, Form, HTTPException, Response, Request
from fastapi.responses import FileResponse
from pydantic import BaseModel
import sqlite3
import os

app = FastAPI()
DB_NAME = "kidcare.db"
DATA_FILE_DIR = "./data_file/"

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/") 
def read_root():
    return {"Selamat datang di kidcare!"}


# ------------------ MEMBUAT DATABASE ------------------

# function membuat database kidcare
@app.get("/init/")
def init_db():
    try:
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        
        create_table_pengasuh = """
        CREATE TABLE tbl_pengasuh (
            id_pengasuh INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            tgl_lahir TEXT,
            alamat TEXT,
            sertifikasi TEXT,
            pengalaman TEXT,
            tarif INTEGER,
            email TEXT UNIQUE NOT NULL,
            telp TEXT,
            foto_pengasuh TEXT, 
            password TEXT NOT NULL,
            umur INTEGER,
            deskripsi TEXT
        )
        """
        cur.execute(create_table_pengasuh)
        
        create_table_user = """
        CREATE TABLE tbl_user (
            id_user INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            jenis_kelamin TEXT,
            tgl_lahir TEXT,
            alamat TEXT,
            pekerjaan TEXT,
            email TEXT UNIQUE NOT NULL,
            foto_user TEXT,
            password TEXT NOT NULL
        )
        """
        cur.execute(create_table_user)
        
        create_table_booking = """
        CREATE TABLE tbl_booking (
            id_booking INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_pengasuh TEXT,
            tgl_mulai TEXT,
            tgl_selesai TEXT,
            waktu_mulai TEXT,
            waktu_selesai TEXTL,
            daftar_kegiatan TEXT,
            catatan TEXT,
            patokan_rumah TEXT,
            id_pengasuh INTEGER,
            id_user INTEGER,
            nama_anak TEXT,
            umur_anak TEXT,
            status TEXT,
            FOREIGN KEY (id_user) REFERENCES tbl_user(id_user),
            FOREIGN KEY (id_pengasuh) REFERENCES tbl_pengasuh(id_pengasuh)
        )
        """
        cur.execute(create_table_booking)
        
        create_table_ulasan = """
        CREATE TABLE tbl_ulasan (
            id_ulasan INTEGER PRIMARY KEY AUTOINCREMENT,
            ulasan TEXT,
            id_pengasuh INTEGER,
            id_user INTEGER,
            FOREIGN KEY (id_pengasuh) REFERENCES tbl_pengasuh(id_pengasuh),
            FOREIGN KEY (id_user) REFERENCES tbl_user(id_user)
        )
        """
        cur.execute(create_table_ulasan)
        
        create_table_aktivitas = """
        CREATE TABLE tbl_aktivitas (
            id_aktivitas INTEGER PRIMARY KEY AUTOINCREMENT,
            aktivitas TEXT,
            id_pengasuh INTEGER,
            id_user INTEGER,
            FOREIGN KEY (id_pengasuh) REFERENCES tbl_pengasuh(id_pengasuh),
            FOREIGN KEY (id_user) REFERENCES tbl_user(id_user)
        )
        """
        cur.execute(create_table_aktivitas)
        
        con.commit()
        
    except Exception as e:
        return {"status": "Terjadi error: {}".format(str(e))}
    
    finally:
        con.close()
    
    return {"status": "OK, database dan tabel berhasil dibuat"}

# ------------------ PENGASUH CRUD ------------------

# function tambah pengasuh
from pydantic import BaseModel
from fastapi import FastAPI, File, UploadFile, Form, HTTPException
from fastapi.responses import JSONResponse
import sqlite3
import uvicorn

app = FastAPI()

class Pengasuh(BaseModel):
    id_pengasuh: int = None
    nama: str = None
    tgl_lahir: str = None
    alamat: str = None
    sertifikasi: str = None
    pengalaman: str = None
    tarif: int = None
    email: str
    telp: str = None
    foto_pengasuh: str = None
    password: str
    umur: int = None
    deskripsi: str = None
    
# Menambahkan middleware CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/tambah_pengasuh/", response_model=Pengasuh, status_code=201)
def tambah_pengasuh(
    nama: str = Form(None),
    tgl_lahir: str = Form(None),
    alamat: str = Form(None),
    sertifikasi: str = Form(None),
    pengalaman: str = Form(None),
    tarif: int = Form(None),
    email: str = Form(...),
    telp: str = Form(None),
    file: UploadFile = File(None),
    password: str = Form(...),
    umur: int = Form(None),
    deskripsi: str = Form(None),
):
    try:
        DB_NAME = "kidcare.db"

        # Simpan file gambar ke direktori jika ada
        file_location = None
        if file:
            file_location = f"./data_file/{file.filename}"
            with open(file_location, "wb") as f:
                f.write(file.file.read())

        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        cur.execute(
            """INSERT INTO tbl_pengasuh (nama, tgl_lahir, alamat, sertifikasi, pengalaman, tarif, email, telp, foto_pengasuh, password, umur, deskripsi) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
            (nama, tgl_lahir, alamat, sertifikasi, pengalaman, tarif, email, telp, file_location, password, umur, deskripsi)
        )

        con.commit()
        pengasuh_id = cur.lastrowid

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Terjadi error: {str(e)}")
    finally:
        con.close()

    response = JSONResponse(content={"status": "Pengasuh berhasil ditambahkan"})
    response.headers["Location"] = f"/tbl_pengasuh/{pengasuh_id}"

    return response

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, debug=True)

        
# function tampilkan semua data pengasuh
@app.get("/tampilkan_semua_pengasuh/")
def tampilkan_semua_pengasuh():
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        for row in cur.execute("SELECT * FROM tbl_pengasuh"):  # Menjalankan query untuk mengambil semua data mahasiswa
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    return {"data": recs}  # Mengembalikan data mahasiswa dalam bentuk respons


# Function untuk mengambil foto pengasuh
@app.get("/getimage/{nama_file}")
async def getImage(nama_file: str):
    return FileResponse("./data_file/" + nama_file) 


# function update patch data pengasuh
from fastapi.middleware.cors import CORSMiddleware

class PengasuhPatch(BaseModel):
    nama: str | None = "kosong"
    tgl_lahir: str | None = "kosong"
    alamat: str | None = "kosong"
    sertifikasi: str | None = "kosong"
    pengalaman: str | None = "kosong"
    tarif: Optional[int] 
    email: str | None = "kosong"
    telp: str | None = "kosong"
    foto_pengasuh: str | None = "kosong"
    password: str | None = "kosong"
    umur: Optional[int] 
    deskripsi: str | None = "kosong"

# Menambahkan middleware CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.patch("/edit_pengasuh_patch/{id_pengasuh}", response_model=PengasuhPatch)
def edit_pengasuh_patch(response: Response, id_pengasuh: int, p: PengasuhPatch):
    try:
        print(str(p))
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from tbl_pengasuh where id_pengasuh = ?", (id_pengasuh,))
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))
    
    if existing_item:
        sqlstr = "update tbl_pengasuh set "
        if p.nama != "kosong":
            if p.nama != None:
                sqlstr = sqlstr + " nama = '{}' ,".format(p.nama)
            else:
                sqlstr = sqlstr + " nama = null ,"
        
        if p.tgl_lahir != "kosong":
            if p.tgl_lahir != None:
                sqlstr = sqlstr + " tgl_lahir = '{}' ,".format(p.tgl_lahir)
            else:
                sqlstr = sqlstr + " tgl_lahir = null ,"
        
        if p.alamat != "kosong":
            if p.alamat != None:
                sqlstr = sqlstr + " alamat = '{}' ,".format(p.alamat)
            else:
                sqlstr = sqlstr + " alamat = null ,"
        
        if p.sertifikasi != "kosong":
            if p.sertifikasi != None:
                sqlstr = sqlstr + " sertifikasi = '{}' ,".format(p.sertifikasi)
            else:
                sqlstr = sqlstr + " sertifikasi = null ,"
        
        if p.pengalaman != "kosong":
            if p.pengalaman != None:
                sqlstr = sqlstr + " pengalaman = '{}' ,".format(p.pengalaman)
            else:
                sqlstr = sqlstr + " pengalaman = null ,"
                
        if p.tarif != "kosong":
            if p.tarif != None:
                sqlstr = sqlstr + " tarif = '{}' ,".format(p.tarif)
            else:
                sqlstr = sqlstr + " tarif = null ,"
                
        if p.email != "kosong":
            if p.email != None:
                sqlstr = sqlstr + " email = '{}' ,".format(p.email)
            else:
                sqlstr = sqlstr + " email = null ," 
                
        if p.telp != "kosong":
            if p.telp != None:
                sqlstr = sqlstr + " telp = '{}' ,".format(p.telp)
            else:
                sqlstr = sqlstr + " telp = null ,"  
                
        if p.foto_pengasuh != "kosong":
            if p.foto_pengasuh != None:
                sqlstr = sqlstr + " foto_pengasuh = '{}' ,".format(p.foto_pengasuh)
            else:
                sqlstr = sqlstr + " foto_pengasuh = null ,"   
                
        if p.password != "kosong":
            if p.password != None:
                sqlstr = sqlstr + " password = '{}' ,".format(p.password)
            else:
                sqlstr = sqlstr + " password = null ,"        
                
        if p.umur != "kosong":
            if p.umur != None:
                sqlstr = sqlstr + " umur = '{}' ,".format(p.umur)
            else:
                sqlstr = sqlstr + " umur = null ,"      
                
        if p.deskripsi != "kosong":
            if p.deskripsi != None:
                sqlstr = sqlstr + " deskripsi = '{}' ,".format(p.deskripsi)
            else:
                sqlstr = sqlstr + " deskripsi = null ,"   
        
        sqlstr = sqlstr[:-1] + " where id_pengasuh = '{}' ".format(id_pengasuh)
        print(sqlstr)
        
        try:
            cur.execute(sqlstr)
            con.commit()
            response.headers["location"] = "/pengasuh/{}".format(id_pengasuh)
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))
    
    else:
        raise HTTPException(status_code=404, detail="Data pengasuh dengan id {} tidak ditemukan.".format(id_pengasuh))

    return p


# function hapus data pengasuh
@app.delete("/hapus_pengasuh/{id_pengasuh}")
def hapus_pengasuh(id_pengasuh: str):
    try:
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)  # Membuka koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk mengeksekusi perintah SQL
        sqlstr = "delete from tbl_pengasuh where id_pengasuh='{}'".format(id_pengasuh)  # String SQL untuk menghapus data mahasiswa berdasarkan nim
        print(sqlstr)  # Mencetak perintah SQL yang akan dieksekusi untuk keperluan debugging
        cur.execute(sqlstr)  # Menjalankan perintah SQL untuk menghapus data dari database
        con.commit()  # Melakukan commit perubahan pada database
    except:
        return {"status": "terjadi error"}  # Mengembalikan respons dengan status error jika terjadi kesalahan dalam proses penghapusan data
    finally:
        con.close()  
    return {"status": "ok"} 


# ------------------ USER CRUD ------------------

from fastapi import Response

class User(BaseModel):
    id_user: int = None
    nama: str = None
    jenis_kelamin: str = None
    tgl_lahir: str = None
    alamat: str = None
    pekerjaan: str = None
    email: str
    foto_user: str = None
    password: str

@app.post("/tambah_user/", response_model=User, status_code=201)
def tambah_user(
    nama: str = Form(None),
    jenis_kelamin: str = Form(None),
    tgl_lahir: str = Form(None),
    alamat: str = Form(None),
    pekerjaan: str = Form(None),
    email: str = Form(...),
    file: UploadFile = File(None),
    password: str = Form(...),
):
    try:
        file_location = None
        if file:
            file_location = f"./data_file/{file.filename}"
            with open(file_location, "wb") as f:
                f.write(file.file.read())

        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        
        cur.execute(
            """INSERT INTO tbl_user (nama, jenis_kelamin, tgl_lahir, alamat, pekerjaan, email, foto_user, password) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)""",
            (nama, jenis_kelamin, tgl_lahir, alamat, pekerjaan, email, file_location, password)
        )

        con.commit()
        user_id = cur.lastrowid

    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi error: {}".format(str(e)))
    finally:
        con.close()
    
    response = Response()
    response.headers["Location"] = f"/tbl_user/{user_id}"
    
    return response
    return {"status": "User berhasil ditambahkan"} 


# function tampilkan semua data user
@app.get("/tampilkan_semua_user/")
def tampilkan_semua_user():
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        for row in cur.execute("SELECT * FROM tbl_user"):  # Menjalankan query untuk mengambil semua data mahasiswa
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    return {"data": recs}  # Mengembalikan data dalam bentuk respons


# function edit data user dengan patch
from fastapi import FastAPI, HTTPException, Response
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional
import sqlite3

class UserPatch(BaseModel):
    nama: str | None = "kosong"
    jenis_kelamin: str | None = "kosong"
    tgl_lahir: str | None = "kosong"
    alamat: str | None = "kosong"
    pekerjaan: str | None = "kosong"
    email: str | None = "kosong"
    foto_user: str | None = "kosong"
    password: str | None = "kosong"

# Menambahkan middleware CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.patch("/edit_user_patch/{id_user}", response_model=UserPatch)
def edit_user_patch(response: Response, id_user: int, u: UserPatch):
    try:
        print(str(u))
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("select * from tbl_user where id_user = ?", (id_user,))
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))
    
    if existing_item:
        sqlstr = "update tbl_user set "
        
        if u.nama != "kosong":
            if u.nama is not None:
                sqlstr += f"nama = '{u.nama}', "
            else:
                sqlstr += "nama = null, "
        
        if u.jenis_kelamin != "kosong":
            if u.jenis_kelamin is not None:
                sqlstr += f"jenis_kelamin = '{u.jenis_kelamin}', "
            else:
                sqlstr += "jenis_kelamin = null, "
        
        if u.tgl_lahir != "kosong":
            if u.tgl_lahir is not None:
                sqlstr += f"tgl_lahir = '{u.tgl_lahir}', "
            else:
                sqlstr += "tgl_lahir = null, "
        
        if u.alamat != "kosong":
            if u.alamat is not None:
                sqlstr += f"alamat = '{u.alamat}', "
            else:
                sqlstr += "alamat = null, "
        
        if u.pekerjaan != "kosong":
            if u.pekerjaan is not None:
                sqlstr += f"pekerjaan = '{u.pekerjaan}', "
            else:
                sqlstr += "pekerjaan = null, "
        
        if u.email != "kosong":
            if u.email is not None:
                sqlstr += f"email = '{u.email}', "
            else:
                sqlstr += "email = null, "
        
        if u.foto_user != "kosong":
            if u.foto_user is not None:
                sqlstr += f"foto_user = '{u.foto_user}', "
            else:
                sqlstr += "foto_user = null, "
        
        if u.password != "kosong":
            if u.password is not None:
                sqlstr += f"password = '{u.password}', "
            else:
                sqlstr += "password = null, "
        
        sqlstr = sqlstr.rstrip(", ") + f" where id_user = {id_user}"
        print(sqlstr)
        
        try:
            cur.execute(sqlstr)
            con.commit()
            response.headers["location"] = f"/user/{id_user}"
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))
    
    else:
        raise HTTPException(status_code=404, detail=f"Data user dengan id {id_user} tidak ditemukan.")

    return u


# function hapus data user
@app.delete("/hapus_user/{id_user}")
def hapus_user(id_user: str):
    try:
        con = sqlite3.connect(DB_NAME)  # Membuka koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk mengeksekusi perintah SQL
        sqlstr = "delete from tbl_user where id_user='{}'".format(id_user)  # String SQL untuk menghapus data mahasiswa berdasarkan nim
        print(sqlstr)  # Mencetak perintah SQL yang akan dieksekusi untuk keperluan debugging
        cur.execute(sqlstr)  # Menjalankan perintah SQL untuk menghapus data dari database
        con.commit()  # Melakukan commit perubahan pada database
    except:
        return {"status": "terjadi error"}  # Mengembalikan respons dengan status error jika terjadi kesalahan dalam proses penghapusan data
    finally:
        con.close()  
    return {"status": "ok"} 

# ------------------ BOOKING CRUD ------------------

# function tambah data booking
from pydantic import BaseModel
from fastapi import FastAPI, HTTPException, Form
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import sqlite3

DB_NAME = 'kidcare.db'

class Booking(BaseModel):
    id_booking: int = None
    nama_pengasuh: str = None
    tgl_mulai: str = None
    tgl_selesai: str = None
    waktu_mulai: str= None
    waktu_selesai: str = None
    daftar_kegiatan: str = None
    catatan: str = None
    patokan_rumah: str = None
    id_pengasuh: int = None
    id_user: int = None
    nama_anak: str = None
    umur_anak: str = None
    status: str = None
    
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/tambah_booking/", status_code=201)
def tambah_booking(
    nama_pengasuh: str = Form(None),
    tgl_mulai: str = Form(None),
    tgl_selesai: str = Form(None),
    waktu_mulai: str = Form(None),
    waktu_selesai: str = Form(None),
    daftar_kegiatan: str = Form(None),
    catatan: str = Form(None),
    patokan_rumah: str = Form(None),
    id_pengasuh: int = Form(None),
    id_user: int = Form(None),
    nama_anak: str = Form(None),
    umur_anak: str = Form(None),
    status: str = Form(None)
):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        
        cur.execute(
            """INSERT INTO tbl_booking (nama_pengasuh, tgl_mulai, tgl_selesai, waktu_mulai, waktu_selesai, daftar_kegiatan, catatan, patokan_rumah, id_pengasuh, id_user, nama_anak, umur_anak, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
            (nama_pengasuh, tgl_mulai, tgl_selesai, waktu_mulai, waktu_selesai, daftar_kegiatan, catatan, patokan_rumah, id_pengasuh, id_user, nama_anak, umur_anak, status)
        )

        con.commit()
        booking_id = cur.lastrowid

    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi error: {}".format(str(e)))
    finally:
        con.close()
    
    response = JSONResponse(content={"status": "Booking berhasil dibuat"})
    response.headers["Location"] = f"/tbl_booking/{booking_id}"

    return response

# function tambah booking 2
from typing import Optional
from pydantic import BaseModel
from fastapi import FastAPI, Response, Request
import sqlite3
from fastapi.middleware.cors import CORSMiddleware

class Booking(BaseModel):
    id_booking: int = None
    nama_pengasuh: str = None
    tgl_mulai: str = None
    tgl_selesai: str = None
    waktu_mulai: str= None
    waktu_selesai: str = None
    daftar_kegiatan: str = None
    catatan: str = None
    patokan_rumah: str = None
    id_pengasuh: int = None
    id_user: int = None
    nama_anak: str = None
    umur_anak: str = None
    status: str = None

#app = FastAPI()

# Menambahkan middleware CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

from fastapi import HTTPException

@app.post("/tambah_bookings/", response_model=Booking, status_code=201)
def tambah_booking(booking: Booking, response: Response, request: Request):
    try:
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        cur.execute(
            """INSERT INTO tbl_booking (nama_pengasuh, tgl_mulai, tgl_selesai, waktu_mulai, waktu_selesai, daftar_kegiatan, catatan, patokan_rumah, id_pengasuh, id_user, nama_anak, umur_anak, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
            (booking.nama_pengasuh, booking.tgl_mulai, booking.tgl_selesai, booking.waktu_mulai, booking.waktu_selesai, booking.daftar_kegiatan, booking.catatan, booking.patokan_rumah, booking.id_pengasuh, booking.id_user, booking.nama_anak, booking.umur_anak, booking.status)
        )

        con.commit()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi error: {}".format(str(e)))
    finally:
        con.close()

    response.headers["Location"] = "/tbl_booking/"
    
    return booking

    
# function tampilkan data booking
@app.get("/tampilkan_semua_booking/")
def tampilkan_semua_booking():
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        for row in cur.execute("SELECT * FROM tbl_booking"):  # Menjalankan query untuk mengambil semua data mahasiswa
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    return {"data": recs}  # Mengembalikan data dalam bentuk respons


@app.get("/tampilkan_booking_tertentu/")
def tampilkan_booking_tertentu(id_user: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        cur.execute("SELECT * FROM tbl_booking WHERE id_user = ?", (id_user,))  # Menjalankan query untuk mengambil semua data mahasiswa
        for row in cur:
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    return {"data": recs}  # Mengembalikan data dalam bentuk respons




# function edit data booking dengan patch
from fastapi import FastAPI, HTTPException, Response
from pydantic import BaseModel
from typing import Optional
import sqlite3

# Model untuk data booking
class BookingPatch(BaseModel):
    nama_pengasuh: str | None = "kosong"
    tgl_mulai: str | None = "kosong"
    tgl_selesai: str | None = "kosong"
    waktu_mulai: str | None = "kosong"
    waktu_selesai: str | None = "kosong"
    daftar_kegiatan: str | None = "kosong"
    catatan: str | None = "kosong"
    patokan_rumah: str | None = "kosong"
    id_user: int = None
    id_pengasuh: int = None
    status: str | None = "kosong"

# Endpoint untuk melakukan update data booking
@app.patch("/edit_booking/{id_booking}", response_model=BookingPatch)
def edit_booking(response: Response, id_booking: int, b: BookingPatch):
    try:
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("SELECT * FROM tbl_booking WHERE id_booking = ?", (id_booking,))
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))

    if existing_item:
        sqlstr = "UPDATE tbl_booking SET "

        # Memeriksa dan membangun string SQL untuk setiap atribut yang di-update
        if b.nama_pengasuh is not None and b.nama_pengasuh.lower() != "kosong":
            sqlstr += f"nama_pengasuh = '{b.nama_pengasuh}', "
        if b.tgl_mulai is not None and b.tgl_mulai.lower() != "kosong":
            sqlstr += f"tgl_mulai = '{b.tgl_mulai}', "
        if b.tgl_selesai is not None and b.tgl_selesai.lower() != "kosong":
            sqlstr += f"tgl_selesai = '{b.tgl_selesai}', " 
        if b.waktu_mulai is not None and b.waktu_mulai.lower() != "kosong":
            sqlstr += f"waktu_mulai = '{b.waktu_mulai}', "    
        if b.waktu_selesai is not None and b.waktu_selesai.lower() != "kosong":
            sqlstr += f"waktu_selesai = '{b.waktu_selesai}', " 
        if b.daftar_kegiatan is not None and b.daftar_kegiatan.lower() != "kosong":
            sqlstr += f"daftar_kegiatan = '{b.daftar_kegiatan}', " 
        if b.catatan is not None and b.catatan.lower() != "kosong":
            sqlstr += f"catatan = '{b.catatan}', "
        if b.patokan_rumah is not None and b.patokan_rumah.lower() != "kosong":
            sqlstr += f"patokan_rumah = '{b.patokan_rumah}', "                                  
        if b.id_pengasuh is not None and b.id_pengasuh != 0:
            sqlstr += f"id_pengasuh = {b.id_pengasuh}, "
        if b.id_user is not None and b.id_user != 0:
            sqlstr += f"id_user = {b.id_user}, "
        if b.status is not None and b.status.lower() != "kosong":
            sqlstr += f"status = '{b.status}', "              

        # Menghapus koma terakhir dan spasi dari string SQL
        sqlstr = sqlstr.rstrip(", ")

        # Menambahkan WHERE clause untuk memastikan hanya data dengan id_booking tertentu yang di-update
        sqlstr += f" WHERE id_booking = {id_booking}"

        try:
            cur.execute(sqlstr)
            con.commit()
            response.headers["location"] = f"/edit_booking/{id_booking}"
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Terjadi exception: {str(e)}")

    else:
        raise HTTPException(status_code=404, detail=f"Data Booking dengan ID {id_booking} tidak ditemukan.")

    return b



# function hapus data booking
@app.delete("/hapus_booking/{id_booking}")
def hapus_booking(id_booking: str):
    try:
        con = sqlite3.connect(DB_NAME)  # Membuka koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk mengeksekusi perintah SQL
        sqlstr = "delete from tbl_booking where id_booking ='{}'".format(id_booking)  # String SQL untuk menghapus data mahasiswa berdasarkan nim
        print(sqlstr)  # Mencetak perintah SQL yang akan dieksekusi untuk keperluan debugging
        cur.execute(sqlstr)  # Menjalankan perintah SQL untuk menghapus data dari database
        con.commit()  # Melakukan commit perubahan pada database
    except:
        return {"status": "terjadi error"}  # Mengembalikan respons dengan status error jika terjadi kesalahan dalam proses penghapusan data
    finally:
        con.close()  
    return {"status": "ok"} 



# data tampil booking dengan foto
from fastapi import FastAPI, HTTPException
import sqlite3

@app.get("/booking_user/")
def booking_user(id_user: int = 1, status: str = "book"):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        # Query dengan JOIN tabel tbl_booking dan tbl_pengasuh untuk mendapatkan foto_pengasuh
        query = """
        SELECT 
            tbl_booking.*, 
            tbl_pengasuh.foto_pengasuh 
        FROM 
            tbl_booking 
        JOIN 
            tbl_pengasuh 
        ON 
            tbl_booking.id_pengasuh = tbl_pengasuh.id_pengasuh 
        WHERE 
            tbl_booking.id_user = ? 
        AND 
            tbl_booking.status = ?
        """
        for row in cur.execute(query, (id_user, status)):  # Menjalankan query dengan parameter id_user dan status
            recs.append({
                "id_booking": row[0],
                "id_user": row[1],
                "id_pengasuh": row[2],
                "tanggal_booking": row[3],
                "status": row[4],
                "keterangan": row[5],
                "foto_pengasuh": row[-1]  # Menambahkan foto_pengasuh dari tabel tbl_pengasuh
            })
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        raise HTTPException(status_code=500, detail="Terjadi error")  # Mengembalikan status error
    finally:
        con.close()  # Menutup koneksi ke database

    if not recs:
        raise HTTPException(status_code=404, detail="Data booking tidak ditemukan")  # Mengembalikan status 404 jika tidak ada data

    return {"data": recs}  # Mengembalikan data dalam bentuk respons

from fastapi import FastAPI, HTTPException, Response
from pydantic import BaseModel
import sqlite3
import json

DB_NAME = 'kidcare.db'

# Pydantic model for the request body
class UlasanRequest(BaseModel):
    ulasan: str
    id_pengasuh: int
    id_user: int

#app = FastAPI()

@app.post("/tambah_ulasan/", status_code=201)
def tambah_ulasan(request: UlasanRequest):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        
        cur.execute(
            """INSERT INTO tbl_ulasan (ulasan, id_pengasuh, id_user) 
            VALUES (?, ?, ?)""",
            (request.ulasan, request.id_pengasuh, request.id_user)
        )

        con.commit()
        ulasan_id = cur.lastrowid

        # Fetch the newly inserted ulasan
        cur.execute("SELECT * FROM tbl_ulasan WHERE id_ulasan = ?", (ulasan_id,))
        row = cur.fetchone()

        response_data = {
            "id_ulasan": row[0],
            "ulasan": row[1],
            "id_pengasuh": row[2],
            "id_user": row[3]
        }

        return Response(content=json.dumps(response_data), media_type="application/json")

    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi error: {}".format(str(e)))
    finally:
        con.close()

# function tampilkan data ulasan
@app.get("/tampilkan_ulasan/")
def tampilkan_ulasan():
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        for row in cur.execute("SELECT * FROM tbl_ulasan"):  # Menjalankan query untuk mengambil semua data mahasiswa
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database
    return {"data": recs}  # Mengembalikan data dalam bentuk respons

# function menampilkan komentar berdasarkan id_pengasuh
from fastapi import FastAPI, HTTPException
import sqlite3

@app.get("/ulasan/{id_pengasuh}")
def ulasan(id_pengasuh: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        # Menjalankan query untuk mengambil data ulasan berdasarkan id_pengasuh
        for row in cur.execute("SELECT * FROM tbl_ulasan WHERE id_pengasuh = ?", (id_pengasuh,)):
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database
    if not recs:  # Jika tidak ada ulasan ditemukan untuk id_pengasuh yang diberikan
        raise HTTPException(status_code=404, detail="Ulasan tidak ditemukan")
    return {"data": recs}  # Mengembalikan data dalam bentuk respons

# function edit data ulasan
from fastapi import FastAPI, HTTPException, Response
from pydantic import BaseModel
import sqlite3

class UlasanPatch(BaseModel):
    ulasan: str = None
    id_pengasuh: int = None
    id_user: int = None

@app.patch("/edit_ulasan/{id_ulasan}", response_model=UlasanPatch)
def edit_ulasan(response: Response, id_ulasan: int, u: UlasanPatch):
    try:
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("SELECT * FROM tbl_ulasan WHERE id_ulasan = ?", (id_ulasan,))
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))

    if existing_item:
        sqlstr = "UPDATE tbl_ulasan SET "

        # Memeriksa dan membangun string SQL untuk setiap atribut yang di-update
        if u.ulasan is not None and u.ulasan != "kosong":
            sqlstr += f"ulasan = '{u.ulasan}', "
        if u.id_pengasuh is not None and u.id_pengasuh != 0:
            sqlstr += f"id_pengasuh = {u.id_pengasuh}, "
        if u.id_user is not None and u.id_user != 0:
            sqlstr += f"id_user = {u.id_user}, "

        # Menghapus koma terakhir dan spasi dari string SQL
        sqlstr = sqlstr.rstrip(", ")

        # Menambahkan WHERE clause untuk memastikan hanya data dengan id_ulasan tertentu yang di-update
        sqlstr += f" WHERE id_ulasan = {id_ulasan}"

        try:
            cur.execute(sqlstr)
            con.commit()
            response.headers["location"] = f"/ulasan/{id_ulasan}"
        except Exception as e:
            raise HTTPException(status_code=500, detail="Terjadi exception: {}".format(str(e)))

    else:
        raise HTTPException(status_code=404, detail=f"Data ulasan dengan ID {id_ulasan} tidak ditemukan.")

    return u

# tampilkan ulasan dan nama_pengulas
from fastapi import FastAPI, HTTPException
import sqlite3

#app = FastAPI()

@app.get("/ulasan_pengguna/{id_pengasuh}")
def ulasan_pengguna(id_pengasuh: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        con.row_factory = sqlite3.Row  # Menyediakan akses kolom dengan nama
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []

        # Menjalankan query untuk mengambil data ulasan dan nama pengguna berdasarkan id_pengasuh
        query = """
            SELECT u.id_ulasan, u.ulasan, u.id_pengasuh, u.id_user, usr.nama, usr.foto_user
            FROM tbl_ulasan u
            JOIN tbl_user usr ON u.id_user = usr.id_user
            WHERE u.id_pengasuh = ?
        """
        cur.execute(query, (id_pengasuh,))
        rows = cur.fetchall()
        print("Rows fetched:", rows)  # Debug output untuk melihat data yang diambil

        for row in rows:
            recs.append({
                "id_ulasan": row["id_ulasan"],
                "ulasan": row["ulasan"],
                "id_pengasuh": row["id_pengasuh"],
                "id_user": row["id_user"],
                "nama": row["nama"],
                "foto_user": row["foto_user"]
            })

    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    if not recs:  # Jika tidak ada ulasan ditemukan untuk id_pengasuh yang diberikan
        raise HTTPException(status_code=404, detail="Ulasan tidak ditemukan")

    return {"data": recs}  # Mengembalikan data dalam bentuk respons

# LOGIN AUTH
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import sqlite3

#app = FastAPI()

# Model untuk login
class LoginRequest(BaseModel):
    email: str
    password: str

# Endpoint login
@app.post("/login")
def login(request: LoginRequest):
    conn = sqlite3.connect("kidcare.db")
    c = conn.cursor()
    
    # Cari pengguna berdasarkan email
    c.execute("SELECT id_user, password FROM tbl_user WHERE email = ?", (request.email,))
    user = c.fetchone()
    
    if user is None:
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    # Verifikasi password
    if user[1] != request.password:
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    # Kembalikan id_user
    return {"id_user": user[0]}

# function menampilkan data user berdasarkan id_user
from fastapi import FastAPI, HTTPException
import sqlite3

@app.get("/data_user/{id_user}")
def data_user(id_user: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        # Menjalankan query untuk mengambil data ulasan berdasarkan id_user
        for row in cur.execute("SELECT * FROM tbl_user WHERE id_user = ?", (id_user,)):
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database
    if not recs:  # Jika tidak ada ulasan ditemukan untuk id_pengasuh yang diberikan
        raise HTTPException(status_code=404, detail="Data user tidak ditemukan")
    return {"data": recs}  # Mengembalikan data dalam bentuk respons


# LOGIN PENGASUH AUTH
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import sqlite3

#app = FastAPI()

# Model untuk login
class LoginRequest(BaseModel):
    email: str
    password: str

# Endpoint login
@app.post("/login_pengasuh")
def login(request: LoginRequest):
    conn = sqlite3.connect("kidcare.db")
    c = conn.cursor()
    
    # Cari pengguna berdasarkan email
    c.execute("SELECT id_pengasuh, password FROM tbl_pengasuh WHERE email = ?", (request.email,))
    pengasuh = c.fetchone()
    
    if pengasuh is None:
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    # Verifikasi password
    if pengasuh[1] != request.password:
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    # Kembalikan id_user
    return {"id_pengasuh": pengasuh[0]}


# function menampilkan data pengasuh berdasarkan id_pengasuh
from fastapi import FastAPI, HTTPException
import sqlite3

@app.get("/data_pengasuh/{id_pengasuh}")
def data_user(id_pengasuh: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        # Menjalankan query untuk mengambil data ulasan berdasarkan id_user
        for row in cur.execute("SELECT * FROM tbl_pengasuh WHERE id_pengasuh = ?", (id_pengasuh,)):
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database
    if not recs:  # Jika tidak ada ulasan ditemukan untuk id_pengasuh yang diberikan
        raise HTTPException(status_code=404, detail="Data user tidak ditemukan")
    return {"data": recs}  # Mengembalikan data dalam bentuk respons

@app.get("/tampilkan_book_aktivitas/")
def tampilkan_book_aktivitas(id_pengasuh: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        cur.execute("SELECT * FROM tbl_booking WHERE id_pengasuh = ?", (id_pengasuh,))  # Menjalankan query untuk mengambil semua data mahasiswa
        for row in cur:
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    return {"data": recs}  # Mengembalikan data dalam bentuk respons


from fastapi import FastAPI, HTTPException, Response
from pydantic import BaseModel
import sqlite3
import json

DB_NAME = 'kidcare.db'

# Pydantic model for the request body
class AktivitasRequest(BaseModel):
    aktivitas: str
    id_pengasuh: int
    id_user: int

#app = FastAPI()

@app.post("/tambah_aktivitas/", status_code=201)
def tambah_aktivitas(request: AktivitasRequest):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        
        cur.execute(
            """INSERT INTO tbl_aktivitas (aktivitas, id_pengasuh, id_user) 
            VALUES (?, ?, ?)""",
            (request.aktivitas, request.id_pengasuh, request.id_user)
        )

        con.commit()
        aktivitas_id = cur.lastrowid

        response_data = {
            "id": aktivitas_id,
            "aktivitas": request.aktivitas,
            "id_pengasuh": request.id_pengasuh,
            "id_user": request.id_user
        }

        return Response(content=json.dumps(response_data), media_type="application/json")

    except Exception as e:
        raise HTTPException(status_code=500, detail="Terjadi error: {}".format(str(e)))
    finally:
        con.close()
        
        
@app.get("/tampilkan_aktivitas_tertentu/")
def tampilkan_aktivitas_tertentu(id_user: int):
    try:
        DB_NAME = "kidcare.db"  # Nama database SQLite
        con = sqlite3.connect(DB_NAME)  # Membuat koneksi ke database
        cur = con.cursor()  # Membuat objek cursor untuk menjalankan perintah SQL
        recs = []
        cur.execute("SELECT * FROM tbl_aktivitas WHERE id_user = ?", (id_user,))  # Menjalankan query untuk mengambil semua data mahasiswa
        for row in cur:
            recs.append(row)  # Menambahkan setiap baris hasil query ke dalam daftar 'recs'
    except Exception as e:  # Menangkap dan menangani kesalahan
        print("Error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()  # Menutup koneksi ke database

    return {"data": recs}  # Mengembalikan data dalam bentuk respons

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import sqlite3

#app = FastAPI()

class BookingStatusUpdate(BaseModel):
    id_booking: int

@app.post("/update_status_booking/")
def update_status_booking(update: BookingStatusUpdate):
    try:
        DB_NAME = "kidcare.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("UPDATE tbl_booking SET status = 'selesai' WHERE id_booking = ?", (update.id_booking,))
        con.commit()

        if cur.rowcount == 0:
            raise HTTPException(status_code=404, detail="Booking not found")
        else:
            return {"status": "Status updated successfully"}
    except Exception as e:
        print("Error:", str(e))
        raise HTTPException(status_code=500, detail="Terjadi error")
    finally:
        if con:
            con.close()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, debug=True)

