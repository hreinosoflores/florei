import React from 'react';
import SubCatArticle from '../components/article/SubCatArticle';
import axios from 'axios';
import { sortSubcatsxNombreAsc } from '../Global';

function SubCatLista() {

    const [subcats, setSubCats] = React.useState([]);

    React.useEffect(() => {

        document.title = `Categorías ${import.meta.env.VITE_TITLE_SUFFIX}`;

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}subcategoria`
                });

                setSubCats(response.data.resultado.filter(subcat => subcat.auditoria.activo));

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, []);

    return (
        <section>
            <h1 className="subcatlista-titulo">Nuestros Productos</h1>
            <section className="grilla">
                {
                    subcats
                        .sort(sortSubcatsxNombreAsc)
                        .map(subcat =>
                            <SubCatArticle key={subcat.id} subcat={subcat} />
                        )
                }
            </section>
        </section>
    )
}

export default SubCatLista;
