import React from 'react'
import toast from 'react-hot-toast';

function showToast(message,isSuccess){

    if(isSuccess){
        toast.success(message);
    }
    else {
        toast.error(message);
    }
}

export default showToast;