import React from 'react';
import error from '../img/error.png';
// import { Link } from 'react-router-dom';
import { FiChevronsLeft } from "react-icons/fi";
import { useNavigate } from 'react-router';

function NotFound() {

    const navigate = useNavigate();

    React.useEffect(() => {
        document.title = `Not Found ${import.meta.env.VITE_TITLE_SUFFIX}`;
    }, []);

    const goBack = () => {
        navigate(-1);
    }

    return (
        <section>
            <h1 className="contacto-titulo">Upps!</h1>
            <div
                className="mx-auto text-verde-bosque border-2 rounded-sm bg-blanco  w-3/4 py-5 px-2 md:w-3/5 lg:w-2/5 lg:px-5">
                <img src={error} alt="error" className="w-32 h-32 mx-auto" />
                <h2 className="text-2xl text-rojo text-center mb-3">Página no Encontrada</h2>
                <p>La página solicitada no existe. Se recomienda: </p>
                <ul className="list-disc pl-5 mb-5">
                    <li>No ingresar texto en la barra de direcciones</li>
                    {/* <li>Navegar desde nuestra web principal <Link className="text-blue-500" to="/">floreiimport.com</Link></li> */}
                </ul>

                <button
                    className="flex justify-center items-center w-1/2 mx-auto rounded bg-verde-bosque text-blanco"
                    onClick={goBack}>
                    <FiChevronsLeft className="h-6 w-6" /> Regresar
                </button>
            </div>
        </section>
    )
}

export default NotFound;
