/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_nasional_adm_pegawai_program_studi;
var m_ref_nasional_adm_pegawai_program_studi_d = _g_root +'/module/ref_nasional_adm_pegawai_program_studi/';
var m_ref_nasional_adm_pegawai_program_studi_kel_program_studi;
var m_ref_nasional_adm_pegawai_program_studi_program_studi;
var m_ref_nasional_adm_pegawai_program_studi_kd_kel_program_studi = '';
var m_ref_nasional_adm_pegawai_program_studi_ha_level = 0;

function m_ref_nasional_adm_pegawai_program_studi_kel_program_studi_on_select_load_program_studi()
{
	if (typeof m_ref_nasional_adm_pegawai_program_studi_kel_program_studi == 'undefined'
	||  typeof m_ref_nasional_adm_pegawai_program_studi_program_studi == 'undefined'
	||  m_ref_nasional_adm_pegawai_program_studi_kd_kel_program_studi == '') {
		return;
	}

	m_ref_nasional_adm_pegawai_program_studi_program_studi.do_load();
}

function M_RefNasionalAdmPegawaiProgramStudiKelProgramStudi(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'kd_kel_program_studi'
		},{
			name	: 'nm_kel_program_studi'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_adm_pegawai_program_studi_d +'data_kel_program_studi.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kode'
			, dataIndex	: 'kd_kel_program_studi'
			, sortable	: true
			, align		: 'center'
			, width		: '100'
			}
		,	{ id		: 'nm_kel_program_studi'
			, header	: 'Nama Kelompok Program Studi'
			, dataIndex	: 'nm_kel_program_studi'
			, sortable	: true
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_ref_nasional_adm_pegawai_program_studi_kd_kel_program_studi = data[0].data['kd_kel_program_studi'];
					} else {
						m_ref_nasional_adm_pegawai_program_studi_kd_kel_program_studi = '';
					}

					m_ref_nasional_adm_pegawai_program_studi_kel_program_studi_on_select_load_program_studi();
				}
			}
		});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_ref
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'west'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_kel_program_studi'
		,	collapsible	: true
		,	width		: '50%'
	});

	this.do_load = function()
	{
		this.store.load({
			scope	:this
		,	callback: function(r,options,success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_nasional_adm_pegawai_program_studi_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefNasionalAdmPegawaiProgramStudiProgramStudi(title)
{
	this.title	= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'kd_kel_program_studi'
		},{
			name	: 'kd_program_studi'
		},{
			name	: 'nm_program_studi'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_adm_pegawai_program_studi_d +'data_program_studi.jsp'
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kode'
			, dataIndex	: 'kd_program_studi'
			, sortable	: true
			, align		: 'center'
			, width		: '100'
			}
		,	{ id		: 'nm_program_studi'
			, header	: 'Nama Program Studi'
			, dataIndex	: 'nm_program_studi'
			, sortable	: true
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_ref
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_program_studi'
		});

	this.do_load = function()
	{
		this.store.load({
			scope		: this
		,	params		: {
				kd_kel_program_studi : m_ref_nasional_adm_pegawai_program_studi_kd_kel_program_studi
			}
		,	callback: function(r, options, success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_nasional_adm_pegawai_program_studi_ha_level < 1) {
			this.grid.setDisabled(true);
		} else {
			this.grid.setDisabled(false);
		}
	}
}

function M_RefNasionalAdmPegawaiProgramStudi()
{
	m_ref_nasional_adm_pegawai_program_studi_kel_program_studi	= new M_RefNasionalAdmPegawaiProgramStudiKelProgramStudi('Kelompok Program Studi');
	m_ref_nasional_adm_pegawai_program_studi_program_studi	= new M_RefNasionalAdmPegawaiProgramStudiProgramStudi('Program Studi');

	this.panel = new Ext.Panel({
			id			: 'ref_nasional_adm_pegawai_program_studi_panel'
		,	layout		: 'border'
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items		: [
				m_ref_nasional_adm_pegawai_program_studi_kel_program_studi.grid
			,	m_ref_nasional_adm_pegawai_program_studi_program_studi.grid
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_nasional_adm_pegawai_program_studi_ha_level			= ha_level;
		m_ref_nasional_adm_pegawai_program_studi_kd_kel_program_studi 	= '';

		m_ref_nasional_adm_pegawai_program_studi_kel_program_studi.do_refresh();
		m_ref_nasional_adm_pegawai_program_studi_program_studi.do_refresh();
	}
}

var m_ref_nasional_adm_pegawai_program_studi = new M_RefNasionalAdmPegawaiProgramStudi();

//@ sourceURL=ref_nasional_adm_pegawai_program_studi.layout.js
