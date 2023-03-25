return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      lazy = true,
    },
  },
}
