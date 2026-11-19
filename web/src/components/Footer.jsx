import React from 'react';
import { FaWhatsapp } from 'react-icons/fa';

function Footer() {
    return (
        <footer className="bg-verde-limo p-4 text-verde-bosque fixed bottom-0 w-full">
            <div className="flex items-center">
                <span className="footer-subtitulo">Contáctenos:</span>
                <FaWhatsapp className="ml-1 h-6 w-6" />
                <span className="ml-1">{import.meta.env.VITE_FOOTER_TELEFONOS}</span>
            </div>

            <span className="footer-subtitulo">Dirección:</span>
            <span className="ml-1" >{import.meta.env.VITE_FLOREI_DIR}</span>
        </footer>
    )
}

export default Footer;
