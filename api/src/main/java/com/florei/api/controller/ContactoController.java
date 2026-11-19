package com.florei.api.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.Agenda;
import com.florei.api.model.Contacto;
import com.florei.api.model.Trabajador;
import com.florei.api.model.view.ContactosWeb;
import com.florei.api.repo.AgendaRepository;
import com.florei.api.repo.ContactoRepository;
import com.florei.api.repo.TrabajadorRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/contacto")
@CrossOrigin
public class ContactoController {
	@Autowired
	private ContactoRepository contactoRepository;

	@Autowired
	private TrabajadorRepository trabajadorRepository;

	@Autowired
	private AgendaRepository agendaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, contactoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Contacto contacto) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			contacto.getAuditoria().setActivo(true);
			contacto.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, contactoRepository.save(contacto));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Contacto contacto) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			contacto.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, contactoRepository.save(contacto));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			contactoRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Contacto contacto = contactoRepository.findById(id).orElse(null);
			if (contacto != null) {
				contacto.getAuditoria().setActivo(!contacto.getAuditoria().getActivo());
				contacto.getAuditoria().setFechaModificacion(new Date());
				contacto.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, contactoRepository.save(contacto));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@GetMapping("web/{id}")
	public Map<String, Object> contactosWeb(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {

			Optional<Trabajador> trabajador = trabajadorRepository.findById(id);

			String nombres = trabajador.get().getPeNatural().getNombres() + " "
					+ trabajador.get().getPeNatural().getApellidos();

			String cargo = trabajador.get().getCargo().getNombre();

			List<Agenda> agendaTrabajador = new ArrayList<>();

			for (Agenda agenda : agendaRepository.findAll()) {
				if (agenda.getPersona().getId() == trabajador.get().getPeNatural().getPersona().getId()) {
					agendaTrabajador.add(agenda);
				}
			}

			List<String> celulares = new ArrayList<String>();
			List<String> fijos = new ArrayList<String>();
			List<String> emails = new ArrayList<String>();

			for (Agenda agenda : agendaTrabajador) {

				Optional<Contacto> contacto = contactoRepository.findById(agenda.getContacto().getId());

				switch (contacto.get().getTipoDato()) {
				case 1:
					celulares.add(contacto.get().getDato());
					break;
				case 2:
					fijos.add(contacto.get().getDato());
					break;
				case 3:
					emails.add(contacto.get().getDato());
					break;

				}
			}

			ContactosWeb contactosWeb = new ContactosWeb(id, nombres, cargo, celulares, fijos, emails);

			Global.resultOK(result, contactosWeb);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
