/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_siswa_pemeliharaan_data_induk_alumni;
var m_adm_siswa_pemeliharaan_data_induk_alumni_d = _g_root +'/module/adm_siswa_pemeliharaan_data_induk_alumni/';

function M_AdmSiswaPemeliharaanDataIndukAlumni(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;
	this.pageSize	= 50;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'no_stl_lulus' }
		,	{ name	: 'tahun_lulus' }
		,	{ name	: 'lanjut_di' }
		,	{ name	: 'tanggal_bekerja' }
		,	{ name	: 'nm_perusahaan' }
	]);

	this.store = new Ext.ux.data.PagingArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pemeliharaan_data_induk_alumni_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.form_lanjut_di = new Ext.form.TextField({
			allowBlank		: true
	});

	this.form_tanggal_bekerja = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: true
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_nm_perusahaan = new Ext.form.TextField({
			allowBlank		: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIS'
			, dataIndex		: 'nis'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Nama Alumni'
			, dataIndex		: 'nm_siswa'
			, sortable		: true
			, width			: 170
			, filterable	: true
			}
		,	{ header		: 'No.STL Lulus'
			, dataIndex		: 'no_stl_lulus'
			, sortable		: true
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Tahun Lulus'
			, dataIndex		: 'tahun_lulus'
			, sortable		: true
			, width			: 90
			, filter		: 
				{
					type	: 'numeric'
				}
			}
		,	{ header		: 'Melanjutkan Pendidikan Di'
			, dataIndex		: 'lanjut_di'
			, sortable		: true
			, editor		: this.form_lanjut_di
			, width			: 160
			, filterable	: true
			}
		,	{ header		: 'Tanggal Bekerja'
			, dataIndex		: 'tanggal_bekerjan'
			, sortable		: true
			, editor		: this.form_tanggal_bekerja
			, align			: 'center'
			, width			: 100
			, filter		: 
				{
					type	: 'date'
				}
			}
		,	{ id			: 'nm_perusahaan'
			, header		: 'Nama Perusahaan'
			, dataIndex		: 'nm_perusahaan'
			, sortable		: true
			, editor		: this.form_nm_perusahaan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			id			: 'adm_siswa_pemeliharaan_data_induk_alumni_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	autoExpandColumn: 'nm_perusahaan'
		,	tbar		: this.toolbar
		,	bbar		: new Ext.PagingToolbar({
							store			: this.store
						,	pageSize		: this.pageSize
						,	firstText		: 'Halaman Awal'
						,	prevText		: 'Halaman Sebelumnya'
						,	beforePageText	: 'Halaman'
						,	afterPageText	: 'dari {0}'
						,	nextText		: 'Halaman Selanjutnya'
						,	lastText		: 'Halaman Terakhir'
						,	plugins			: [this.filters]
						})
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		if (this.ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa		: record.data['id_siswa']
					,	lanjut_di		: record.data['lanjut_di']
					,	tanggal_bekerja	: record.data['tanggal_bekerja']
					,	nm_perusahaan	: record.data['nm_perusahaan']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_alumni_d +'submit.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		delete this.store.lastParams;
		
		this.store.load({
			params	: {
				start	: 0
			,	limit	: this.pageSize
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_adm_siswa_pemeliharaan_data_induk_alumni = new M_AdmSiswaPemeliharaanDataIndukAlumni('Pemeliharaan Data Induk Alumni');

//@ sourceURL=m_adm_siswa_pemeliharaan_data_induk_alumni.layout.js
