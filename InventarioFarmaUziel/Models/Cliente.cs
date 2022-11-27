using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace InventarioFarmaUziel.Models;

public partial class Cliente
{
    public int IdCliente { get; set; }

    public string Pncliente { get; set; } = null!;

    public string? Sncliente { get; set; }

    public string Pacliente { get; set; } = null!;

    public string? Sacliente { get; set; }

    public string DirC { get; set; } = null!;

    public string? TelCliente { get; set; }

    public virtual ICollection<Venta> Venta { get; } = new List<Venta>();
}
