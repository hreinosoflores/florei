package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
import com.florei.api.repo.AgendaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/agenda")
@CrossOrigin
public class AgendaController {

	@Autowired
	private AgendaRepository agendaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, agendaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Agenda agenda) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			agenda.getAuditoria().setActivo(true);
			agenda.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, agendaRepository.save(agenda));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Agenda agenda) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			agenda.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, agendaRepository.save(agenda));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			agendaRepository.deleteById(id);
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
			Agenda agenda = agendaRepository.findById(id).orElse(null);
			if (agenda != null) {
				agenda.getAuditoria().setActivo(!agenda.getAuditoria().getActivo());
				agenda.getAuditoria().setFechaModificacion(new Date());
				agenda.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, agendaRepository.save(agenda));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
