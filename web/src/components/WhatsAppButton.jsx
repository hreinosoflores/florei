import React from 'react'
import { FaWhatsapp } from 'react-icons/fa';


export const WhatsAppButton = () => {

    const phoneNumber = import.meta.env.VITE_FOOTER_TELEFONOS;
    const message = "Hola, Humberto, me agrada tu sitio web"; // Mensaje opcional

    const handleWhatsAppClick = () => {
        const url = `https://wa.me/${phoneNumber}?text=${encodeURIComponent(message)}`;
        window.open(url, "_blank");
    };

    return (
        <div className="fixed bottom-10 right-10">
            <span className="relative flex h-12 w-12">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                <button
                    onClick={handleWhatsAppClick}
                    className="relative inline-flex rounded-full h-12 w-12
                        bg-green-500 
                        text-white 
                        shadow-lg"
                    aria-label="WhatsApp"
                >
                    <FaWhatsapp className="h-8 w-8 m-auto" />
                </button>
            </span>
        </div >
    )
}
