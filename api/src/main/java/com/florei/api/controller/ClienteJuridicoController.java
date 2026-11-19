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

import com.florei.api.model.ClienteJuridico;
import com.florei.api.repo.ClienteJuridicoRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cliente/juridico")
@CrossOrigin
public class ClienteJuridicoController {

	@Autowired
	private ClienteJuridicoRepository clienteJuridicoRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, clienteJuridicoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody ClienteJuridico clienteJuridico) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			clienteJuridico.getAuditoria().setActivo(true);
			clienteJuridico.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, clienteJuridicoRepository.save(clienteJuridico));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody ClienteJuridico clienteJuridico) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			clienteJuridico.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, clienteJuridicoRepository.save(clienteJuridico));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			clienteJuridicoRepository.deleteById(id);
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
			ClienteJuridico clienteJuridico = clienteJuridicoRepository.findById(id).orElse(null);
			if (clienteJuridico != null) {
				clienteJuridico.getAuditoria().setActivo(!clienteJuridico.getAuditoria().getActivo());
				clienteJuridico.getAuditoria().setFechaModificacion(new Date());
				clienteJuridico.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, clienteJuridicoRepository.save(clienteJuridico));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
