import React from 'react';
import ContactoArticle from '../components/article/ContactoArticle';
import axios from 'axios';

function Contacto() {

    const [card1, setCard1] = React.useState();

    // const [card2, setCard2] = React.useState();

    React.useEffect(() => {

        document.title = `Contáctenos ${import.meta.env.VITE_TITLE_SUFFIX}`;

        async function fetchData() {
            try {

                const response_1 = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}contacto/web/4`
                });

                let id = response_1.data.resultado.idTrab;
                let nombres = response_1.data.resultado.nombres;
                let cargo = response_1.data.resultado.cargo;
                let celulares = response_1.data.resultado.celulares;
                let fijos = response_1.data.resultado.fijos;
                let emails = response_1.data.resultado.emails;

                let article = <ContactoArticle
                    key={id}
                    nombres={nombres}
                    cargo={cargo}
                    celulares={celulares}
                    fijos={fijos}
                    emails={emails}
                />;

                setCard1(article);

                // const response_2 = await axios({
                //     method: 'GET',
                //     url: `${import.meta.env.VITE_URL_API}contacto/web/1`
                // });

                // id = response_2.data.resultado.idTrab;
                // nombres = response_2.data.resultado.nombres;
                // cargo = response_2.data.resultado.cargo;
                // celulares = response_2.data.resultado.celulares;
                // fijos = response_2.data.resultado.fijos;
                // emails = response_2.data.resultado.emails;

                // article = <ContactoArticle
                //     key={id}
                //     nombres={nombres}
                //     cargo={cargo}
                //     celulares={celulares}
                //     fijos={fijos}
                //     emails={emails}
                // />;

                // setCard2(article);

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, []);

    return (
        <section>
            <h1 className="contacto-titulo">Comuníquese con nosotros para mayor información</h1>
            <section className="grid grid-cols-1 gap-4 md:grid-cols-2 md:gap-8">
                {card1}
                {/* {card2} */}
            </section>
        </section>
    )
}

export default Contacto;
