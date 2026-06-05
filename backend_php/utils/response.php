<?php
function sendResponse($success, $message, $data = null)
{
    $response = [
        "success" => $success,
        "message" => $message,
    ];
    if ($data !== null) {
        $response["data"] = $data;
    }
    echo json_encode($response);
    exit();
}
