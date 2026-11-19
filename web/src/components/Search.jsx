import React from 'react';
import { FaSearch } from "react-icons/fa";
import { useNavigate } from 'react-router';

function Search() {

    const navigate = useNavigate();

    const filtrar = (e) => {
        let query = e.target.value.toString();

        if (query.length === 0) navigate("/");
        else navigate("/productos/buscar/" + query);
    }

    return (
        <div className="flex justify-between items-center border border-gris-claro shadow rounded py-1 px-3 text-base lg:w-72">
            <input
                className="w-full"
                type="text"
                placeholder="Buscar Producto..."
                onChange={filtrar} />
            <FaSearch className="text-gray-400 h-4 w-4 ml-1" />
        </div>
    )
}

export default Search;
