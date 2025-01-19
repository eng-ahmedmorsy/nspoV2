import socket
import json
from deepface import DeepFace


def verify_matches(img1_path, img2_path):
    try:
        result = DeepFace.verify(
            img1_path=img1_path,
            img2_path=img2_path,
            anti_spoofing=True
        )

        return {
            "is_verified": result["verified"],
            "message": "ok",
        }

    except ValueError as e:

        error_message = str(e).lower()

        if "processing img1_path" in error_message or "spoof" in error_message or "fake" in error_message:

            return {

                "is_verified": False,

                "message": "spoof",

            }


        else:

            return {

                "is_verified": False,

                "message": "error"
            }



    except Exception as e:

        return {

            "is_verified": False,

            "message": f"Error: {str(e)}",

        }
    except Exception as e:
        return {
            "is_verified": False,
            "message": str(e),
        }


def check_face_is_real(img_path):
    try:
        result = DeepFace.extract_faces(
            img_path=img_path,
            anti_spoofing=True
        )
        return {
            "is_verified": result[0]["is_real"],
            "message": "ok",

        }
    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            "is_verified": False,
            "message": str(e),
        }


server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('127.0.0.1', 8888))
server_socket.listen(1)

print("Server is ready and listening...")

while True:
    try:
        client_socket, addr = server_socket.accept()
        print(f"Connection from: {addr}")

        data = client_socket.recv(1024).decode('utf-8')
        if not data:
            break

        data = json.loads(data)
        img1_path = data.get("img1_path")
        img2_path = data.get("img2_path")
        is_new_face = data.get("isNewFace")

        if is_new_face:
            result = check_face_is_real(img1_path)
        else:
            result = verify_matches(img1_path, img2_path)

        client_socket.send(json.dumps(result).encode('utf-8'))

    except ConnectionResetError as e:
        print(f"Connection was reset by the client: {str(e)}")
    except Exception as e:
        print(f"Failed to process the request: {str(e)}")
    finally:
        client_socket.close()
